# frozen_string_literal: true

class TokenValidatorService
  def initialize(token)
    @token = token
  end

  def valid?
    client.check_application_authorization(@token).present?
  rescue Octokit::Error
    false
  end

  private

  def client
    Octokit::Client.new(
      client_id: ENV['GITHUB_CLIENT_ID'],
      client_secret: ENV['GITHUB_CLIENT_SECRET']
    )
  end
end
