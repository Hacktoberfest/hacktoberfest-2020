# frozen_string_literal: true

# Fetches Pull Requests for a user from the GitHub API
# Returns an array of GraphqlPullRequest instances
class GithubPullRequestService
  class UserNotFoundOnGithubError < StandardError; end
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

  def initialize(user, randomize_token: false)
    @user = user
    @randomize_token = randomize_token
  end

  def pull_requests
    return @pull_requests if @pull_requests.present?

    response = Rails.cache.fetch(cache_key, expires_in: 1.minute) do
      client.request(PULL_REQUEST_QUERY, nodeId: user_graphql_node_id)
    end

    if response['errors']
      if response['errors'][0]['type'] == 'NOT_FOUND'
        raise UserNotFoundOnGithubError
      end
    end

    @pull_requests = response.data.node.pullRequests.nodes.map do |pr|
      GithubPullRequest.new(pr)
    end
  end

  private

  def cache_key
    "user/#{@user.id}/github_pull_request_service/response"
  end

  def client
    @client ||= if @randomize_token == true
                  GithubRetryableGraphqlApiClient.new(
                    access_token: GithubTokenService.random,
                    retries: 0
                  )
                else
                  GithubRetryableGraphqlApiClient.new(
                    access_token: @user.provider_token,
                    retries: 2
                  )
                end
  end

  def user_graphql_node_id
    encode_string = "04:User#{@user.uid}"
    Base64.encode64(encode_string).chomp
  end
end
