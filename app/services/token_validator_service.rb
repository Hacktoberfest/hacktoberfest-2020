# frozen_string_literal: true

class TokenValidatorService
  def initialize(token)
    @token = token
  end

  def valid?
    client.rate_limit!.remaining.positive?
  rescue Octokit::Unauthorized
    false
  end

  private

  def client
    Octokit::Client.new(access_token: @token)
  end
end
