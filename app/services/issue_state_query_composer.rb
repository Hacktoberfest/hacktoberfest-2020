# frozen_string_literal: true

module IssueStateQueryComposer
  module_function

  ISSUE_STATE_QUERY = <<~GRAPHQL
    query GetIssueState($ownerName: String!,
                        $repoName: String!,
                        $issueNumber: Int!) {
      rateLimit {
        cost
        limit
        remaining
        resetAt
        }
        repository(owner: $ownerName,
          name: $repoName) {
            issue(number: $issueNumber) {
              state
            }
        }
    }
  GRAPHQL

  def compose(owner_name:, repo_name:, issue_number:)
    {
      query: ISSUE_STATE_QUERY,
      variables: {
        ownerName: owner_name,
        repoName: repo_name,
        issueNumber: issue_number
      }
    }
  end
end
