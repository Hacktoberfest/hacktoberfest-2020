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

    # new_prs allows us to track if a new PR exists, and update segment
    # This is hacky, I know, I'm sorry
    new_prs = false

    prs = filtered_github_pull_requests(github_pull_requests).map do |ghpr|
      # Try finding the existing PR
      found_pr = PullRequest.from_github_pull_request(ghpr, false)
      next found_pr if found_pr

      # If not, create the new PR and we will need to update segment
      new_prs = true
      PullRequest.from_github_pull_request(ghpr)
    end

    # If there were new PRs, update segment
    UserPullRequestSegmentUpdaterService.call(@user) if new_prs

    # Done!
    prs
  end

  def waiting_prs
    all.select(&:waiting?)
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

  def scoring_pull_requests_receipt
    scoring_pull_requests.map do |pr|
      pr.github_pull_request.graphql_hash
    end
  end

  def non_scoring_pull_requests
    all.drop(scoring_pull_requests.count)
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
      Time.parse(e.created_at).utc >= Hacktoberfest.start_date &&
        Time.parse(e.created_at).utc <= Hacktoberfest.end_date
    end
  end
end
