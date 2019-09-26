# frozen_string_literal: true

class ProfilePagePresenter
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def display_pre_launch?
    Hacktoberfest.pre_launch?
  end

  def display_results?
    Hacktoberfest.ended? && @user.won_hacktoberfest?
  end

  def timeline_pull_requests
    @user.timeline_pull_requests
  end

  def score
    @user.score
  end

  def name
    @user.name
  end
end
