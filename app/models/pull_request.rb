# frozen_string_literal: true

class PullRequest < ApplicationRecord
  attr_reader :github_pull_request

  delegate :title, :body, :url, :created_at, :name, :owner, :repo_id,
           :name_with_owner, :label_names, to: :github_pull_request

  state_machine initial: :new do
    event :spam do
      transition %i[new waiting eligible] => :spam,
                 if: ->(pr) { pr.spammy? }
    end

    event :invalid do
      transition %i[new waiting eligible] => :invalid,
                 if: ->(pr) { pr.labelled_invalid? }
    end

    event :eligible do
      transition %i[new waiting] => :eligible,
                 if: ->(pr) { !pr.spammy? && !pr.labelled_invalid? && pr.older_than_week? }
    end

    event :waiting do
      transition %i[new spam invalid] => :waiting,
                 if: ->(pr) { !pr.spammy? && !pr.labelled_invalid? && !pr.older_than_week? }
    end

    before_transition to: %i[waiting], from: %i[new] do |pr, _transition|
      pr.waiting_since = pr.github_pull_request.created_at
    end

    before_transition to: %i[waiting], from: %i[spam invalid] do |pr, _transition|
      pr.waiting_since = Time.zone.now
    end
  end

  def check_state
    return if spam
    return if invalid
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
    label_names.include?('invalid')
  end

  def spammy?
    SpamRepositoryService.call(repo_id)
  end

  def set_github_pull_request(ghpr)
    @github_pull_request = ghpr
  end

  def self.from_github_pull_request(ghpr)
    pr = self.find_or_create_by(gh_id: ghpr.id)
    pr.set_github_pull_request(ghpr)
    pr.check_state
    pr
  end
end
