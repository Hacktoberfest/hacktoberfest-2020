# frozen_string_literal: true

class User < ApplicationRecord
  state_machine initial: :new do
    event :register do
      transition new: :registered
    end
    event :wait do 
      transition registered: :waiting
    end
    event :complete do
      transition waiting: :complete
    end
    event :incomplete do 
      transition waiting: :complete
    end

    state :registered do
      validates :terms_acceptance, acceptance: true
      validates :email, presence: true
    end

    state :waiting do 
      with_options unless: :hacktoberfest_ended? do |user|
        user.validates :score, numericality: { greater_than_or_equal_to: 4 }
      end
    end

    state :complete do
      validates :score_mature_prs, numericality: { greater_than_or_equal_to: 4 }
    end

    state :incomplete do
    end
  end


  # with_options if: :run_registration_validations do |confirm|
  #   confirm.validates :terms_acceptance, acceptance: true
  #   confirm.validates :email, presence: true
  # end ask daniel: when the user crosses 4 eloigible PRs... do you want 7 days from that point {might be easier} 
  
  # Method when i score:
  
  #   gives you the PR that you're scoring- geting all the open PRS not invalid sort by date from oldest to newest take the four oldest

  #   provisional score and active score

  #   provisional hasnt cured 

  #   actual score method - starting with oct 1 test whjich pontetc

  #   should be the first four that they did 

  #   from waiting to one complete/incomplete/banned .. scorecard 

  # def update_registration_validations(*args)
  #   @run_registration_validations = true
  #   updated = update(*args)
  #   @run_registration_validations = false
  #   updated
  # end

  # review
  # completed
  # coupon applied
  # cooling

  protected

  def score
    pr_service = PullRequestService.new(self)
    pr_service.score
  end

  def score_mature_prs 
    pr_service = PullRequestService.new(self)
    pr_service.count_mature_prs
  end

  def hacktoberfest_ended?
    result = Date.parse("01/11/2019") - Date.today
    result < 0
  end
end
