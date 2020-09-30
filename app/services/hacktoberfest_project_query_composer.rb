# frozen_string_literal: true

module HacktoberfestProjectQueryComposer
  module_function

  PROJECT_IMPORT_QUERY = <<~GRAPHQL
    query FindHacktoberfestIssues($queryString: String!,
                                  $first: Int!,
                                  $after: String) {
      rateLimit {
        cost
        limit
        remaining
        resetAt
      }
      search(query: $queryString,
             type: ISSUE,
             first: $first,
             after: $after) {
          issueCount
          pageInfo {
            endCursor
            hasNextPage
          }
          edges {
            node {
              ... on Issue {
                bodyText
                databaseId
                number
                title
                url
                participants {
                  totalCount
                }
                timeline {
                  totalCount
                }
                repository {
                  databaseId
                  description
                  name
                  nameWithOwner
                  url
                  primaryLanguage {
                    name
                  }
                  stargazers {
                    totalCount
                  }
                  watchers {
                    totalCount
                  }
                  forks {
                    totalCount
                  }
                  codeOfConduct {
                    url
                  }
                }
              }
            }
          }
        }
      }
  GRAPHQL

  def compose_query_string(query_string = nil)
    date_now = Time.zone.now.strftime('%Y-%m-%d')
    search_clauses = [
      'state:open',
      'label:hacktoberfest',
      'no:assignee'
    ]
    search_clauses.push(query_string) if query_string.present?
    search_clauses.push('created:' + date_now)
    search_clauses.join(' ')
  end

  def compose_variables(query_string, results_per_page, cursor = nil)
    variables = {
      queryString: compose_query_string(query_string),
      first: results_per_page
    }
    variables.merge!(after: cursor.to_s) if cursor.present?
    variables
  end

  def compose(query_string: nil, results_per_page:, cursor:)
    {
      query: PROJECT_IMPORT_QUERY,
      variables: compose_variables(query_string, results_per_page, cursor)
    }
  end
end
