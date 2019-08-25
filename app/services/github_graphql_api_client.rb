# frozen_string_literal: true

class GithubGraphqlApiClient
  GITHUB_GRAPHQL_API_URL = 'https://api.github.com/graphql'

  def initialize(access_token:)
    @access_token = access_token
  end

  def request(query, variables = {})
    response = Faraday.post(GITHUB_GRAPHQL_API_URL,
                            { query: query, variables: variables }.to_json,
                            'Authorization': "bearer #{@access_token}",
                            'Content-Type': 'application/json')
    Hashie::Mash.new(JSON.parse(response.body))
  end
end

# stub mock - vcr
# happy - it returns a Hashie with right props (succesful?)

# unhappy - it raises an error
# expect it to raise bad request (bad credentials)
# expect to raise server err ()
# use webmock to fake a 500
# expect new request to eq 500
