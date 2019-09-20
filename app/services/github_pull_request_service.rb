# frozen_string_literal: true

# Fetches Pull Requests for a user from the GitHub API
# Returns an array of GraphqlPullRequest instances
class GithubPullRequestService
  attr_reader :user

  PULL_REQUEST_QUERY = <<~GRAPHQL
    query($username:String!) {
      user(login: $username) {
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

  def initialize(user)
    @user = user
  end

  def pull_requests
    client = GithubGraphqlApiClient.new(access_token: @user.provider_token)
    response = client.request(PULL_REQUEST_QUERY, username: @user.name
    response.data.user.pullRequests.nodes.map do |pr|
      GithubPullRequest.new(pr)
    end
  end
end
