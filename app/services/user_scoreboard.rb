# frozen_string_literal: true

require 'octokit'

class UserScoreboard
  attr_reader :user, :start_date, :end_date

  SCOREBOARD_QUERY = <<~GRAPHQL
    query($username:String!) {
      user(login: $username) {
        pullRequests(states: OPEN last: 100) {
          nodes {
            id
            title
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

  def score
    client = GithubGraphqlApiClient.new(access_token: user.provider_token)
    response = client.request(SCOREBOARD_QUERY, username: "mkcode")
    prs = response.data.user.pullRequests.nodes.map{ |pr| GraphqlPullRequest.new(pr) }

    PullRequestFilterService.new(prs).filter.count
  end
end
