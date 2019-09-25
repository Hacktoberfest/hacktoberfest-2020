# frozen_string_literal: true

class ProfilePagePresenter

  def initialize(user)
    @user = user
  end

  def display_pre_launch?
    Hacktoberfest.pre_launch?
  end

  def display_timeline?
    Hacktoberfest.active?
  end

  def dispay_results?
    Hacktoberfest.ended?
  end

  def score
    @user.score
  end
end
