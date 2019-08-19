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
    # client = Octokit::Client.new(access_token: ENV['GITHUB_ACCESS_TOKEN'])
    #  byebug
    #  prs = client.search_issues('is:pr user: #{client.user.name}')
    return 5
  end
end
