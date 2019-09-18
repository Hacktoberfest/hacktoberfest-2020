# frozen_string_literal: true

class GithubGraphqlApiClient
  GITHUB_GRAPHQL_API_URL = 'https://api.github.com/graphql'
  attr_writer :client

  def initialize(access_token:, client: nil)
    @access_token = access_token
    @client = client
  end

  def client
    @client ||= Hacktoberfest.client
  end

  def request(query, variables = {})
    query, variables = normalize_hash_args(query, variables)
    response = client.post(GITHUB_GRAPHQL_API_URL,
                           { query: query, variables: variables }.to_json,
                           'Authorization': "bearer #{@access_token}",
                           'Content-Type': 'application/json')
    Hashie::Mash.new(JSON.parse(response.body))
  end

  private

  def normalize_hash_args(query, variables)
    return [query, variables] unless query.is_a?(Hash)

    variables = query.delete(:variables)
    [query[:query], variables]
  end
end
