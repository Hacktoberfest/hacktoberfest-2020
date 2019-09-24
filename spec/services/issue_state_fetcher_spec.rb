require "rails_helper"

RSpec.describe IssueStateFetcher do
  describe "#fetch!" do
    it "queries the state of the given issue" do
      owner_name = "ACME"
      repo_name = "RoadRunnerRepellant"
      repository = create(
        :repository,
        name: repo_name,
        full_name: "#{owner_name}/#{repo_name}",
      )
      issue = create(:issue, repository: repository)
      issue_state_query = double(:issue_state_query)
      allow(IssueStateQueryComposer).to receive(:compose)
        .and_return(issue_state_query)
      api_client = double(:api_client)
      response = {
        "data" => {
          "repository" => {
            "issue" => {
              "state" => "OPEN",
            },
          },
        },
      }
      allow(api_client).to receive(:request)
        .and_return(response)
      issue_state_fetcher = IssueStateFetcher.new(api_client: api_client)

      issue_state_fetcher.fetch!(issue)

      expect(IssueStateQueryComposer).to have_received(:compose)
        .with(
          issue_number: issue.number,
          owner_name: owner_name,
          repo_name: repo_name,
        )
      expect(api_client).to have_received(:request)
        .with(issue_state_query)
    end

    context "When the API returns a state of 'CLOSED'" do
      it "returns 'CLOSED'" do
        issue = create(:issue)
        api_issue_state = "CLOSED"
        json_response_body = <<~JSON_RESPONSE_BODY
          {
            "data": {
              "rateLimit": {
                "cost": 1,
                "limit": 5000,
                "remaining": 4992,
                "resetAt": "2017-09-26T19:38:33Z"
              },
              "repository": {
                "issue": {
                  "state": "#{api_issue_state}"
                }
              }
            }
          }
        JSON_RESPONSE_BODY
        response = double(:response, body: json_response_body)
        allow(RestClient).to receive(:post).and_return(response)
        access_token = "fake access token"
        client = GithubGraphqlApiClient.new(access_token: access_token)
        fetcher = IssueStateFetcher.new(api_client: client)

        fetched_issue_state = fetcher.fetch!(issue)

        expect(fetched_issue_state).to eq api_issue_state
      end
    end

    context "When the API returns a state of 'OPEN'" do
      it "returns 'OPEN'" do
        issue = create(:issue)
        api_issue_state = "OPEN"
        json_response_body = <<~JSON_RESPONSE_BODY
          {
            "data": {
              "rateLimit": {
                "cost": 1,
                "limit": 5000,
                "remaining": 4992,
                "resetAt": "2017-09-26T19:38:33Z"
              },
              "repository": {
                "issue": {
                  "state": "#{api_issue_state}"
                }
              }
            }
          }
        JSON_RESPONSE_BODY
        response = double(:response, body: json_response_body)
        allow(RestClient).to receive(:post).and_return(response)
        access_token = "fake access token"
        client = GithubGraphqlApiClient.new(access_token: access_token)
        fetcher = IssueStateFetcher.new(api_client: client)

        fetched_issue_state = fetcher.fetch!(issue)

        expect(fetched_issue_state).to eq api_issue_state
      end
    end

    context "When the API returns a repository not found error" do
      it "raises an IssueStateFetcherInvalidRepoError with the error data" do
        issue = create(:issue)
        api_client = double(:api_client)
        bad_query = "find me the repository of all repositories"
        allow(IssueStateQueryComposer).to receive(:compose)
          .and_return(bad_query)
        error_message = "Could not resolve to a Repository with the name 'Paradox'."
        errors = [
          {
            "message" => error_message,
            "type" => "NOT_FOUND",
            "path" => ["repository"],
            "locations" => [
              {
                "line" => 1,
                "column" => 127,
              }
            ]
          },
        ]
        response = {
          "data" => {
            "rateLimit" => {
              "cost" => 1,
              "limit" => 5000,
              "remaining" => 4063,
              "resetAt" => "2017-09-26T22:03:51Z",
            },
            "repository" => nil
          },
          "errors" => errors,
        }
        allow(api_client).to receive(:request)
          .and_return(response)
        allow(IssueStateFetcherInvalidRepoError).to receive(:new)
          .and_return(
            IssueStateFetcherInvalidRepoError.new(
              error_message,
              errors: errors,
              query: bad_query,
            )
          )
        issue_state_fetcher = IssueStateFetcher.new(api_client: api_client)

        expect do
          issue_state_fetcher.fetch!(issue)
        end.to raise_error(IssueStateFetcherInvalidRepoError)
        expect(IssueStateFetcherInvalidRepoError).to have_received(:new)
          .with(
            error_message,
            errors: errors,
            query: bad_query,
          )
      end
    end

    context "When the API returns other errors" do
      it "raises an IssueStateFetcherError with the error data" do
        issue = create(:issue)
        api_client = double(:api_client)
        bad_query = "1/0"
        allow(IssueStateQueryComposer).to receive(:compose)
          .and_return(bad_query)
        error_message = "Some random error"
        errors = [
          {
            "message" => error_message,
          },
        ]
        response = {
          "data" => {
            "rateLimit" => {
              "cost" => 1, "limit" => 5000, "remaining" => 4063, "resetAt" => "2017-09-26T22:03:51Z"
            },
            "repository" => nil
          },
          "errors" => errors,
        }
        allow(api_client).to receive(:request)
          .and_return(response)
        allow(IssueStateFetcherError).to receive(:new)
          .and_return(
            IssueStateFetcherError.new(
              error_message,
              errors: errors,
              query: bad_query,
            )
          )
        issue_state_fetcher = IssueStateFetcher.new(api_client: api_client)

        expect do
          issue_state_fetcher.fetch!(issue)
        end.to raise_error(IssueStateFetcherError)
        expect(IssueStateFetcherError).to have_received(:new)
          .with(
            error_message,
            errors: errors,
            query: bad_query,
          )
      end
    end
  end
end
