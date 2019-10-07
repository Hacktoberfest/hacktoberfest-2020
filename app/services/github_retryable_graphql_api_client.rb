# frozen_string_literal: true

class GithubRetryableGraphqlApiClient
  # Workaround for github bug where graphql queries return 502 inexplicably for
  # some otherwise valid user auth tokens
  BACKUP_TOKEN_USER_IDS = [1, 10, 12].freeze

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
    # @access_token = GithubTokenService.random
    # Select our known good auth tokens as backup
    @access_token = User.where(id: BACKUP_TOKEN_USER_IDS )
                        .pluck(:provider_token)
                        .sample
  end
end
