# frozen_string_literal: true

# Fetches Pull Requests for a user from the GitHub API
# Returns an array of GraphqlPullRequest instances
class GithubPullRequestService
  attr_reader :user

  PULL_REQUEST_QUERY = <<~GRAPHQL
    query($nodeId:ID!){
      node(id:$nodeId) {
        ... on User {
          pullRequests(states: [OPEN, MERGED, CLOSED] last: 100) {
            nodes {
              id
              title
              body
              url
              createdAt
              repository{
                databaseId
              }
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
    }
  GRAPHQL

  def initialize(user)
    @user = user
  end

  def pull_requests
    client = GithubGraphqlApiClient.new(access_token: @user.provider_token)
    response = client.request(PULL_REQUEST_QUERY, nodeId: user_graphql_node_id)
    response.data.node.pullRequests.nodes.map do |pr|
      GithubPullRequest.new(pr)
    end
  end

  private

  def user_graphql_node_id
    encode_string = "04:User#{@user.uid}"
    Base64.encode64(encode_string).chomp
  end
end
