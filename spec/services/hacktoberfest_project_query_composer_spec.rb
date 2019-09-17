require "rails_helper"

RSpec.describe HacktoberfestProjectQueryComposer do
  describe ".compose" do
    context "When not given a cursor" do
      it "returns a project graphql json query for the first set of results" do
        results_per_page = 1000000
        graphql_json_query_without_pagination = {
          query: "query FindHacktoberfestIssues($queryString: String!) { rateLimit { cost limit remaining resetAt } search(query: $queryString, type: ISSUE, first: #{results_per_page}) { issueCount pageInfo { endCursor hasNextPage } edges { node { ... on Issue { bodyText databaseId number title url participants { totalCount } timeline { totalCount } repository { databaseId description name nameWithOwner url primaryLanguage { name } stargazers { totalCount } watchers { totalCount } forks { totalCount } codeOfConduct { url } } } } } } }",
          variables: { "queryString" => "state:open label:hacktoberfest" }
        }

        query = HacktoberfestProjectQueryComposer.compose(
          results_per_page: results_per_page,
          cursor: nil,
        )

        expect(query).to eq graphql_json_query_without_pagination
      end
    end

    context "When given a cursor" do
      it "returns a project graphql json query paginated to the cursor" do
        results_per_page = 1000000
        cursor = "a_dog_eared_page"
        graphql_json_query_with_pagination = {
          query: "query FindHacktoberfestIssues($queryString: String!) { rateLimit { cost limit remaining resetAt } search(query: $queryString, type: ISSUE, first: #{results_per_page}, after:\"#{cursor}\") { issueCount pageInfo { endCursor hasNextPage } edges { node { ... on Issue { bodyText databaseId number title url participants { totalCount } timeline { totalCount } repository { databaseId description name nameWithOwner url primaryLanguage { name } stargazers { totalCount } watchers { totalCount } forks { totalCount } codeOfConduct { url } } } } } } }",
          variables: { "queryString" => "state:open label:hacktoberfest" }
        }

        query = HacktoberfestProjectQueryComposer.compose(
          results_per_page: results_per_page,
          cursor: cursor,
        )

        expect(query).to eq graphql_json_query_with_pagination
      end
    end
  end
end
