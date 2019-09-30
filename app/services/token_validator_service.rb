# frozen_string_literal: true

class TokenValidatorService
  def initialize(token)
    @token = token
  end

  def valid?
    client.rate_limit!.remaining > 0
  rescue Octokit::Unauthorized
    false
  end

  private

  def client
    Octokit::Client.new(access_token: @token)
  end
end
