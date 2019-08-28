# frozen_string_literal: true

class GithubGraphqlApiClient
  GITHUB_GRAPHQL_API_URL = 'https://api.github.com/graphql'
  attr_writer :client

  def initialize(access_token:)
    @access_token = access_token
  end

  def client
    @client ||= Hacktoberfest.client
  end

  def request(query, variables = {})
    binding.pry
    response = client.post(GITHUB_GRAPHQL_API_URL,
                          { query: query, variables: variables }.to_json,
                          'Authorization': "bearer #{@access_token}",
                          'Content-Type': 'application/json')
    Hashie::Mash.new(JSON.parse(response.body))
  end
end
