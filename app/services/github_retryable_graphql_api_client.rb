# frozen_string_literal: true

class GithubRetryableGraphqlApiClient

  def initialize(access_token:, retries: 0)
    @access_token = access_token
    @retries = retries
  end

  def client(access_token:)
    GithubGraphqlApiClient.new(access_token: access_token)
  end

  def request(query, variables = {})
    client(access_token: @access_token).request(query, variables)
  rescue Faraday::ClientError => e
    if e.response[:status] == 502 && @retries > 0
      @retries -= 1
      change_access_token
      retry
    else
      raise e
    end
  end

  private

  def change_access_token
    @access_token = GithubTokenService.random
  end
end
