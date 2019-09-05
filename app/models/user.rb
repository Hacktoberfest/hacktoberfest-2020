# frozen_string_literal: true

class User < ApplicationRecord
  with_options unless: -> (user) { user.state == 'new' } do |user|
    user.validates :terms_acceptance, acceptance: true
    user.validates :email, presence: true
  end

  state_machine initial: :new do
    event :register do
      transition new: :registered
    end
    event :wait do 
      transition registered: :waiting
    end
    event :complete do
      transition waiting: :completed
    end
    event :incomplete do 
      transition waiting: :incompleted
    end

    state :registered

    state :waiting do 
      with_options unless: :hacktoberfest_ended? do |user|
        user.validates :score, numericality: { greater_than_or_equal_to: 4 }
      end
    end

    state :completed do
      validates :won_hacktoberfest? , inclusion: [true]
    end

    state :incompleted do
      validates :hacktoberfest_ended? , inclusion: [true]
      validates :won_hacktoberfest?, inclusion: [false]
    end
  end

  protected

  def score
    pr_service = PullRequestService.new(self)
    pr_service.score
  end

  def score_mature_prs 
    pr_service = PullRequestService.new(self)
    pr_service.count_mature_prs
  end

  def won_hacktoberfest?
    score_mature_prs >= 4
  end

  def hacktoberfest_ended?
    result = Date.parse("01/11/2019") - Date.today
    result < 0
  end
end
