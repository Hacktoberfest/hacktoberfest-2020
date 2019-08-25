# frozen_string_literal: true

class GraphqlClientHelper
  def mock_query
    QUERY = <<~GRAPHQL
    query {
      user(login: 'mkcode') {
        pullRequests(states: OPEN last: 100) {
          nodes {
            id
            title
            body
            url
            createdAt
            labels(first: 100) {
              edges {
                node {
                  name
                }
              }
            }
          }
        }
      }
    }
    GRAPHQL
    QUERY
  end
end
