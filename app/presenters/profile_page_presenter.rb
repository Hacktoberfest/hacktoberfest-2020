# frozen_string_literal: true

class ProfilePagePresenter
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def display_pre_launch?
    Hacktoberfest.pre_launch?
  end

  def display_post_launch?
    Hacktoberfest.ended?
  end

  def display_coupon?
    @user.won_shirt? || @user.won_sticker?
  end

  def display_sticker_gift?
    @user.gifted_sticker?
  end

  def display_waiting_for_prize?
    @user.completed?
  end

  def display_thank_you?
    @user.incompleted?
  end

  def display_waiting_thank_you?
    @user.waiting? && Hacktoberfest.ended?
  end

  def scoring_pull_requests
    # If the user has won, show their winning PRs
    return persisted_winning_pull_requests if @user.receipt

    # Show all the PRs until we reach four winning/waiting
    counter = 0
    @user.pull_requests.take_while do |pr|
      counter += 1 if pr.eligible? || pr.waiting?
      counter <= 4
    end
  end

  def persisted_winning_pull_requests
    @user.receipt.map do |pr|
      PullRequest.from_github_pull_request(
        GithubPullRequest.new(Hashie::Mash.new(pr))
      )
    end
  end

  def non_scoring_pull_requests
    # Show all the PRs not in the scoring section
    scoring = scoring_pull_requests.map(&:github_id)
    @user.pull_requests.reject { |pr| scoring.include?(pr.github_id) }
  end

  def score
    if @user.completed_or_won?
      4
    else
      @user.score || 0
    end
  end

  def bonus_score
    @user.bonus_score || 0
  end

  def name
    @user.name
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
