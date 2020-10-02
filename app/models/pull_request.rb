# frozen_string_literal: true

class PullRequest < ApplicationRecord
  attr_reader :github_pull_request

  delegate :title, :body, :url, :created_at, :name, :owner, :repo_id,
           :name_with_owner, :label_names, :repository_topics, :merged?, to: :github_pull_request

  state_machine initial: :new do
    event :spam_repo do
      transition %i[new waiting] => :spam_repo,
                 if: ->(pr) { pr.spammy? }
    end

    event :invalid_label do
      transition %i[new waiting] => :invalid_label,
                 if: ->(pr) { pr.labelled_invalid? }
    end

    event :topic_missing do
      transition %i[new waiting] => :topic_missing,
                 unless: ->(pr) { pr.in_topic_repo? }
    end

    event :eligible do
      transition %i[new waiting] => :eligible,
                 if: ->(pr) { !pr.spammy_or_invalid? && pr.older_than_week? }
    end

    event :waiting do
      transition %i[new spam_repo invalid_label topic_missing] => :waiting,
                 if: ->(pr) { !pr.spammy_or_invalid? && !pr.older_than_week? }
    end

    before_transition to: %i[waiting],
                      from: %i[new] do |pr, _transition|
      pr.waiting_since = pr.created_at
      pr.save!
    end

    before_transition to: %i[waiting],
                      from: %i[spam_repo invalid_label topic_missing] do |pr, _transition|
      pr.waiting_since = Time.zone.now
      pr.save!
    end
  end

  def check_state
    return if spam_repo
    return if invalid_label
    return if topic_missing
    return if eligible

    waiting
  end

  def most_recent_time
    return waiting_since unless waiting_since.nil?

    github_pull_request.created_at
  end

  def older_than_week?
    most_recent_time <= (Time.zone.now - 7.days)
  end

  def labelled_invalid?
    return false if merged?

    label_names.select { |l| l[/\b(invalid|spam)\b/i] }.any?
  end

  def spammy?
    SpamRepositoryService.call(repo_id)
  end

  def spammy_or_invalid?
    labelled_invalid? || spammy?
  end

  def in_topic_repo?
    # Don't have this requirement for old PRs
    return true if Time.parse(created_at).utc <= Time.parse('2020-10-03 12:00:00 UTC')

    repository_topics.select { |topic| topic.strip == 'hacktoberfest' }.any?
  end

  def github_id
    github_pull_request.id
  end

  def define_github_pull_request(ghpr)
    @github_pull_request = ghpr
  end

  def self.from_github_pull_request(ghpr, create = true)
    pr = create ? find_or_create_by(gh_id: ghpr.id) : find_by(gh_id: ghpr.id)
    return unless pr

    pr.define_github_pull_request(ghpr)
    pr.check_state
    pr
  end
end
