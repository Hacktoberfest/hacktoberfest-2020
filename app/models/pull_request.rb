# frozen_string_literal: true

class PullRequest < ApplicationRecord
  attr_reader :github_pull_request

  delegate :title, :body, :url, :created_at, :name, :owner, :repo_id,
           :name_with_owner, :label_names, :merged?, to: :github_pull_request

  state_machine initial: :new do
    event :spam_repo do
      transition %i[new created waiting] => :spam_repo,
                 if: ->(pr) { pr.spammy? }
    end

    event :invalid_label do
      transition %i[new created waiting] => :invalid_label,
                 if: ->(pr) { pr.labelled_invalid? }
    end

    # A pull request that has been opened, accepted, not spammy & older than 7 days
    # Once here, a pull request cannot leave this state
    event :eligible do
      transition %i[waiting] => :eligible,
                 if: ->(pr) { !pr.spammy_or_invalid? && pr.older_than_week? && pr.is_accepted? }
    end

    # A pull request that has been opened and accepted, not spammy & newer than 7 days
    # Once here a pull request can go back to created if un-accepted (possible if the accepted label is removed)
    event :waiting do
      transition %i[new created spam_repo invalid_label] => :waiting,
                 if: ->(pr) { !pr.spammy_or_invalid? && !pr.older_than_week? && pr.is_accepted? }
    end

    # A pull request that has been opened, not spammy, not accepted
    event :created do
      transition %i[new waiting spam_repo invalid_label] => :created,
                 if: ->(pr) { !pr.spammy_or_invalid? && !pr.older_than_week? && !pr.is_accepted? }
    end

    before_transition to: %i[waiting] do |pr, _transition|
      pr.waiting_since = Time.zone.now
      pr.save!
    end
  end

  def check_state
    return if spam_repo
    return if invalid_label
    return if eligible
    return if waiting

    created
  end

  def older_than_week?
    return false if waiting_since.nil?

    waiting_since <= (Time.zone.now - 7.days)
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

  def labelled_accepted?
    label_names.select { |l| l.downcase.strip == 'hacktoberfest-accepted' }.any?
  end

  def is_accepted?
    merged? || labelled_accepted?
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
