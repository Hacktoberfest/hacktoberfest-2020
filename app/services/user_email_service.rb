# frozen_string_literal: true

require 'octokit'

class UserEmailService
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def emails
    client = Octokit::Client.new(access_token: @user.provider_token)
    selected = client.emails.select do |email_obj|
      email_obj if email_obj.verified && !email_obj.email.include?('noreply')
    end
    selected.map(&:email)
  end
end
