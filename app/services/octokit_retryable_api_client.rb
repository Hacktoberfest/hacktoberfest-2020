# frozen_string_literal: true

class OctokitRetryableAPIClient
  # Workaround for github bug where octokit queries return 502 inexplicably for
  # some otherwise valid user auth tokens
  BACKUP_TOKEN_USER_IDS = [1, 10, 12].freeze

  def initialize(access_token:, retries: 0)
    @access_token = access_token
    @retries = retries
  end

  def client(access_token:)
    Octokit::Client.new(access_token: access_token)
  end

  def request(object, query, variables = {})
    client(access_token: @access_token).send(object, query, variables)
  rescue Octokit::ClientError => e
    raise e unless e.response_status == 502 && @retries.positive?

    @retries -= 1
    change_access_token
    retry
  end

  private

  def change_access_token
    # @access_token = GithubTokenService.random
    # Select our known good auth tokens as backup
    @access_token = User.where(id: BACKUP_TOKEN_USER_IDS)
                        .pluck(:provider_token)
                        .sample
  end
end
