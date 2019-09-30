# frozen_string_literal: true

class ValidUserTokenService
  def initialize(user)
    @user = user
  end

  def valid?
    client.check_application_authorization(user_token).present?
  rescue Octokit::Error
    false
  end

  private

  def user_token
    @user.provider_token
  end

  def client
    Octokit::Client.new(
      client_id: ENV['GITHUB_CLIENT_ID'],
      client_secret: ENV['GITHUB_CLIENT_SECRET']
    )
  end
end
