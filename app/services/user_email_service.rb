# frozen_string_literal: true

class UserEmailService
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def emails
    client = Octokit::Client.new(access_token: @user.provider_token)
    selected = client.emails.select do |email|
      email unless email.visibility.nil?
    end
    selected.map(&:email)
  end
end
