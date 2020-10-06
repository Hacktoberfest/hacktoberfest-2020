# frozen_string_literal: true

class PullRequest < ApplicationRecord
  attr_reader :github_pull_request

  delegate :title, :body, :url, :name, :owner, :repo_id,
           :name_with_owner, :label_names, :repository_topics, :merged?,
           :approved?, to: :github_pull_request

  state_machine initial: :new do
    event :spam_repo do
      transition all - %i[eligible] => :spam_repo,
                 if: ->(pr) { pr.spammy? }
    end

    event :invalid_label do
      transition all - %i[eligible] => :invalid_label,
                 if: ->(pr) { pr.labelled_invalid? }
    end

    event :topic_missing do
      transition all - %i[eligible] => :topic_missing,
                 unless: ->(pr) { pr.in_topic_repo? }
    end

    event :not_accepted do
      transition all - %i[eligible] => :not_accepted,
                 unless: ->(pr) { pr.maintainer_accepted? }
    end

    event :eligible do
      transition %i[new waiting] => :eligible,
                 if: lambda { |pr|
                       pr.passed_review_period? &&
                         !pr.spammy? &&
                         !pr.labelled_invalid? &&
                         pr.in_topic_repo? &&
                         pr.maintainer_accepted?
                     }
    end

    event :waiting do
      transition all - %i[eligible] => :waiting,
                 if: lambda { |pr|
                       !pr.passed_review_period? &&
                         !pr.spammy? &&
                         !pr.labelled_invalid? &&
                         pr.in_topic_repo? &&
                         pr.maintainer_accepted?
                     }
    end

    after_transition to: %i[waiting],
                     from: %i[new] do |pr, _transition|
      pr.waiting_since = Time.parse(pr.github_pull_request.created_at).utc
      pr.save!
    end

    after_transition to: %i[waiting],
                     from: all - %i[new waiting] do |pr, _transition|
      pr.waiting_since = Time.zone.now
      pr.save!
    end
  end

  def check_state
    return if spam_repo
    return if invalid_label
    return if topic_missing
    return if not_accepted
    return if eligible

    waiting
  end

  def most_recent_time
    return waiting_since unless waiting_since.nil?

    Time.parse(github_pull_request.created_at).utc
  end

  def passed_review_period?
    most_recent_time <= (Time.zone.now - 14.days)
  end

  def labelled_invalid?
    return false if merged?

    label_names.select { |l| l[/\b(invalid|spam)\b/i] }.any?
  end

  def labelled_accepted?
    label_names.select { |l| l.downcase.strip == 'hacktoberfest-accepted' }.any?
  end

  def spammy?
    SpamRepositoryService.call(repo_id)
  end

  def in_topic_repo?
    # Don't have this requirement for old PRs
    return true if created_at <= Hacktoberfest.rules_date

    # PR-specific opt-in
    return true if labelled_accepted?

    repository_topics.select { |topic| topic.strip == 'hacktoberfest' }.any?
  end

  def maintainer_accepted?
    # Don't have this requirement for old PRs
    return true if created_at <= Hacktoberfest.rules_date

    merged? || approved? || labelled_accepted?
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
