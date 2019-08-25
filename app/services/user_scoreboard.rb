# frozen_string_literal: true

class UserScoreboard
  attr_reader :user

  SCOREBOARD_QUERY = <<~GRAPHQL
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
    client = GithubGraphqlApiClient.new(access_token: user.provider_token)
    response = client.request(SCOREBOARD_QUERY, username: @user.name)
    prs = response.data.user.pullRequests.nodes.map do |pr|
      GraphqlPullRequest.new(pr)
    end
    @pull_requests = PullRequestFilterService.new(prs).filter.last(4)
  end

  def score
    @score = @pull_requests.nil? ? 0 : @pull_requests.count
  end
end
