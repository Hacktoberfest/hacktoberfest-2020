# frozen_string_literal: true

# Top level interface for grabbing user PRs
class PullRequestService
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def all
    # Create this service when we lookup spammy repos:
    # in order to lookup all Repo Spammy states in SQL query
    # prs = PullRequestStateLookupService.new(filtered_github_pull_requests)
    filtered_github_pull_requests(github_pull_requests).map do |ghpr|
      PullRequest.new(ghpr)
    end
  end

  def all_by_state
    {
      invalid: all.select { |p| p.label_names.include?('invalid') },
      eligible: all.reject { |p| p.label_names.include?('invalid') }
    }
  end

  def score
    all_by_state[:eligible].count || 0
  end

  def count_matured_prs
    find_mature(all_by_state[:eligible]).count
  end

  protected

  def github_pull_requests
    github_prs = GithubPullRequestService.new(user)
    github_prs.pull_requests
  end

  def find_mature(prs)
    mature_prs = prs.select do |e|
      DateTime.parse(e.created_at) < (DateTime.now - 7.days)
    end
    mature_prs
  end

  def filtered_github_pull_requests(prs)
    prs.select do |e|
      e.created_at >= ENV['START_DATE'] && e.created_at <= ENV['END_DATE']
    end
  end
end
