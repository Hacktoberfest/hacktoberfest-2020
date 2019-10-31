# frozen_string_literal: true

# Top level interface for grabbing user PRs
class PullRequestService
  attr_reader :user

  def initialize(user, randomize_token: false)
    @user = user
    @randomize_token = randomize_token
  end

  def all
    # Create this service when we lookup spammy repos:
    # in order to lookup all Repo Spammy states in SQL query
    # prs = PullRequestStateLookupService.new(filtered_github_pull_requests)
    filtered_github_pull_requests(github_pull_requests).map do |ghpr|
      PullRequest.new(ghpr)
    end
  end

  def eligible_prs
    all.select(&:eligible?)
  end

  def scoring_pull_requests
    counter = 0
    all.take_while do |pr|
      counter += 1 if pr.eligible?
      counter <= 4
    end
  end

  def non_scoring_pull_requests
    if @user.completed_or_won?
      non_scoring_pull_requests_for_completed_or_won
    else
      all.drop(scoring_pull_requests.count)
    end
  end

  def non_scoring_pull_requests_for_completed_or_won
    persisted_prs_ids = persisted_winning_pull_requests.map(&:id)
    non_scoring_prs = []
    all.select do |pr|
      non_scoring_prs << pr unless persisted_prs_ids.include?(pr.id)
    end
    non_scoring_prs
  end

  def persisted_winning_pull_requests
    @user.receipt.map do |pr|
      github_hash = Hashie::Mash.new(pr).github_pull_request.graphql_hash
      PullRequest.new(GithubPullRequest.new(github_hash))
    end
  end

  protected

  def github_pull_requests
    @github_pull_requests ||=
      GithubPullRequestService.new(
        user, randomize_token: @randomize_token
      ).pull_requests
  end

  def filtered_github_pull_requests(prs)
    prs.select do |e|
      e.created_at >= ENV['START_DATE'] && e.created_at <= ENV['END_DATE']
    end
  end
end
