# frozen_string_literal: true

# Top level interface for grabbing user PRs
class PullRequestService
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def all
    # Create this service when we lookup spammy repos in order to lookup
    # all Repo Spammy states in SQL query
    # prs = PullRequestStateLookupService.new(filtered_github_pull_requests)
    filtered_github_pull_requests.map{ |ghpr| PullRequest.new(ghpr) }
  end

  def all_by_state

  end

  def all_eligible
    all.select(&:eligible?)
  end

  def score
    all_eligible.count || 0
  end

  private

  def github_pull_requests
    github_prs = GithubPullRequestService.new(user)
    github_prs.pull_requests
  end

  def filtered_github_pull_requests
    github_pull_requests.select do |e|
      e.created_at >= ENV['START_DATE'] && e.created_at <= ENV['END_DATE']
    end
  end
end
