# frozen_string_literal: true

module IssueUpdateService
  module_function

  def call(issue)
    access_token = GithubTokenService.random
    api_client = GithubGraphqlApiClient.new(access_token: access_token)
    issue_state_fetcher = IssueStateFetcher.new(api_client: api_client)
    begin
      state = issue_state_fetcher.fetch!(issue)
      IssueStateUpdater.update(issue: issue, state: state)
    rescue IssueStateFetcherInvalidRepoError
      issue.destroy
    end
  end
end
