# frozen_string_literal: true

class ProfilePagePresenter
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def display_pre_launch?
    Hacktoberfest.pre_launch?
  end

  def display_coupon?
    @user.won_shirt? || @user.won_sticker?
  end

  def display_waiting_for_prize?
    @user.completed?
  end

  def display_thank_you?
    @user.incompleted?
  end

  def scoring_pull_requests
    if @user.receipt
      persisted_winning_pull_requests
    else
      @user.scoring_pull_requests
    end
  end

  def persisted_winning_pull_requests
    @user.persisted_winning_pull_requests
  end

  def non_scoring_pull_requests
    @user.non_scoring_pull_requests
  end

  def score
    if @user.completed_or_won?
      4
    else
      @user.score || 0
    end
  end

  def bonus_score
    (@user.eligible_pull_requests_count || 0) - @user.score
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

  def show_congratulations?
    @user.completed_or_won?
  end

  def code
    if (coupon = @user.shirt_coupon)
      coupon.code
    elsif (coupon = @user.sticker_coupon)
      coupon.code
    end
  end
end
