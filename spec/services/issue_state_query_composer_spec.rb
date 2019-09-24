require "rails_helper"

RSpec.describe IssueStateQueryComposer do
  describe ".compose" do
    it "returns the correct query to get the state of the given issue" do
      owner_name = "ACME"
      repo_name = "RoadRunnerRepellant"
      issue_number = 13

      query = IssueStateQueryComposer.compose(
        owner_name: owner_name,
        repo_name: repo_name,
        issue_number: issue_number,
      )

      expected_query = {
        "query" => "query GetIssueState($ownerName: String!, $repoName: String!, $issueNumber: Int!) { rateLimit { cost limit remaining resetAt } repository(owner: $ownerName, name: $repoName) { issue(number: $issueNumber) { state } } }",
        "variables" => { "ownerName" => owner_name, "repoName" => repo_name, "issueNumber" => issue_number }
      }.to_json
      expect(query).to eq expected_query
    end
  end
end
