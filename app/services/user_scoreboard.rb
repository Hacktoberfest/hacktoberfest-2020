# frozen_string_literal: true

require 'octokit'

class UserScoreboard
  attr_reader :user, :start_date, :end_date

  def initialize(user, start_date, end_date)
    @start_date = start_date
    @end_date = end_date
    @user = user
  end

  def score
    binding.pry
    client = Octokit::Client.new(access_token: user.provider_token)
    prs = client.search_issues("is:pr user: #{client.user.name}")
    prs.total_count
  end
end
