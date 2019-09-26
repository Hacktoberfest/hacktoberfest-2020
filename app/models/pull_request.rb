# frozen_string_literal: true

class PullRequest
  attr_reader :github_pull_request

  def initialize(github_pull_request)
    @github_pull_request = github_pull_request
  end

  delegate :id, :title, :body, :url, :state, :created_at,
           :label_names, to: :github_pull_request

  def status
    if label_names.include?('invalid')
      'invalid'
    else
      'eligible'
    end
  end

  def state
    @github_pull_request.state
  end

  def eligible?
    status == 'eligible'
  end

  def mature?
    pr_date = DateTime.parse(@github_pull_request.created_at)

    pr_date < (DateTime.now - Hacktoberfest.pull_request_maturation_days)
  end

  def merged?
    state == 'MERGED'
  end
end
