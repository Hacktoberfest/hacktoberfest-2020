# frozen_string_literal: true

class ProfilePagePresenter

  def initialize(user)
    @user = user
  end

  def display_pre_launch?
    Hacktoberfest.pre_launch?
  end

  def display_timeline?
    Hacktoberfest.active? || (Hacktoberfest.ended? && !@user.won_hacktoberfest?)
  end

  def display_results?
    Hacktoberfest.ended? && @user.won_hacktoberfest?
  end

  def pull_request_timeline
    counter = 0
    @user.pull_requests.take_while do |pr|
      counter += 1 if pr.eligible?
      counter <= 4
    end
  end

  def score
    @user.score
  end
end
