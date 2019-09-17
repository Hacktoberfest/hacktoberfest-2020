class HacktoberfestProjectQueryComposer
  def self.compose(results_per_page:, cursor:)
    pagination_clause = ""
    if cursor.present?
      pagination_clause = ", after:\"#{cursor}\""
    end
    {
      "query" => "query FindHacktoberfestIssues($queryString: String!) { rateLimit { cost limit remaining resetAt } search(query: $queryString, type: ISSUE, first: #{results_per_page}#{pagination_clause}) { issueCount pageInfo { endCursor hasNextPage } edges { node { ... on Issue { bodyText databaseId number title url participants { totalCount } timeline { totalCount } repository { databaseId description name nameWithOwner url primaryLanguage { name } stargazers { totalCount } watchers { totalCount } forks { totalCount } codeOfConduct { url } } } } } } }",
      "variables" => { "queryString" => "state:open label:hacktoberfest" }
    }.to_json
  end
end
