# frozen_string_literal: true

class IssueStateQueryComposer
  def self.compose(owner_name:, repo_name:, issue_number:)
    query = <<~GRAPHQL
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
      }'
    GRAPHQL
    {
      query: query,
      variables: {
        ownerName: owner_name,
        repoName: repo_name,
        issueNumber: issue_number
      }
    }
  end
end
