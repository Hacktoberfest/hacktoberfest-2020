class IssueStateQueryComposer
  def self.compose(owner_name:, repo_name:, issue_number:)
    {
      "query" => "query GetIssueState($ownerName: String!, $repoName: String!, $issueNumber: Int!) { rateLimit { cost limit remaining resetAt } repository(owner: $ownerName, name: $repoName) { issue(number: $issueNumber) { state } } }",
      "variables" => {
        "ownerName" => owner_name,
        "repoName" => repo_name,
        "issueNumber" => issue_number,
      }
    }.to_json
  end
end
