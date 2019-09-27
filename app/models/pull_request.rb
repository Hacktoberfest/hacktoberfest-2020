# frozen_string_literal: true

class PullRequest
  attr_reader :github_pull_request

  def initialize(github_pull_request)
    @github_pull_request = github_pull_request
  end

  delegate :id, :title, :body, :url, :created_at, :name, :owner, :repo_id,
           :name_with_owner, :label_names, to: :github_pull_request

  def state
    if spammy?
      'spammy'
    elsif label_names.include?('invalid')
      'invalid'
    else
      'eligible'
    end
  end

  def eligible?
    return false if spammy?
    state == 'eligible'
  end

  def mature?
    pr_date = DateTime.parse(@github_pull_request.created_at)

    pr_date < (DateTime.now - Hacktoberfest.pull_request_maturation_days)
  end

  def spammy?
    repo = Repository.find_by_gh_database_id(repo_id)
    return false unless repo

    repo.banned?
  end
end
