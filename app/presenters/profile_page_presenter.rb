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
    # if user has a receipt, run persisted method to display their stored PR info
    if @user.receipt
      persisted_winning_pull_requests.select(&:eligible?)
    else
      @user.scoring_pull_requests
    end
  end

  def persisted_winning_pull_requests
    # User receipt is not being persisted in completed state
    # pr object coming in has additional "github_pull_request" key and
    # "graphql_hash" keys, object needs to be identical to
    # @current_user.scoring_pull_requests
    @user.receipt.map do |pr|
      hashie_prs = Hashie::Mash.new(pr).github_pull_request.graphql_hash
      PullRequest.new(GithubPullRequest.new(hashie_prs))
    end
  end

  def non_scoring_pull_requests
    @user.non_scoring_pull_requests
  end

  def score
    # ignore state and just check to see if receipt exists & use eligible PRs in receipt to calculate score
    if @user.receipt
      persisted_winning_pull_requests.select(&:eligible?).count
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
    @user.won_shirt? || @user.won_sticker? || @user.completed?
  end

  def code
    if (coupon = @user.shirt_coupon)
      coupon.code
    elsif (coupon = @user.sticker_coupon)
      coupon.code
    end
  end
end
