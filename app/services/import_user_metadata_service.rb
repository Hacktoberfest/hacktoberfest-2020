# frozen_string_literal: true

require 'octokit'

module ImportUserMetadataService
  module_function

  def call(user)
    client = OctokitRetryableAPIClient.new(access_token: user.provider_token)

    user_data = client.request(:user, name=user.name)

    UserStat.where(user_id: user.id).first_or_create(data: user_data)
  end
end