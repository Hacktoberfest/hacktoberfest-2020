# frozen_string_literal: true

class ProfilePagePresenter
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def display_pre_launch?
    Hacktoberfest.pre_launch?
  end

  def display_winners?
    Hacktoberfest.ended? && @user.won_hacktoberfest?
  end

  def display_participants?
    Hacktoberfest.ended? && (@user.incompleted? ||  @user.completed?)
  end

  def scoring_pull_requests
    @user.scoring_pull_requests
  end

  def non_scoring_pull_requests
    @user.non_scoring_pull_requests
  end

  def score
    @user.score
  end

  def name
    @user.name
  end

  def waiting_since_for_js
    @user.waiting_since&.httpdate
  end

  def show_timer?
    @user.waiting?
  end

  def show_coupon
    if @user.state == 'won_shirt'
      coupon = @user.shirt_coupon
    else
      coupon = @user.sticker_coupon
    end
    coupon.code
  end
end
