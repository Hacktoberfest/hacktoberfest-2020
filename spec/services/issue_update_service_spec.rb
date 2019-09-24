# frozen_string_literal: true

require 'rails_helper'

RSpec.describe IssueUpdateService do
  context 'When the repo returned by the API is invalid' do
    it 'handles and logs the error, and deletes the related issue and repo' do
      allow(GithubTokenService).to receive(:random)
        .and_return('123')
      api_client = double(:api_client)
      allow(GithubGraphqlApiClient).to receive(:new)
        .and_return(api_client)
      issue_state_fetcher = double(:issue_state_fetcher)
      allow(IssueStateFetcher).to receive(:new)
        .with(api_client: api_client)
        .and_return(issue_state_fetcher)
      exception = IssueStateFetcherInvalidRepoError.new(
        "Error...",
        errors: [ { "some" => "error" } ],
        query: "some query",
      )
      allow(issue_state_fetcher).to receive(:fetch!)
        .and_raise(exception)
      bad_issue = create(:issue)

      IssueUpdateService.call(bad_issue)

      expect(Issue.find_by(id: bad_issue.id)).to be_nil
    end
  end

  context 'When the issue has an updated state' do
    xit 'updates the issue state' do
    end
  end
end
