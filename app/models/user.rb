# frozen_string_literal: true

class User < ApplicationRecord
  with_options unless: ->(user) { user.state == 'new' } do
    validates :terms_acceptance, acceptance: true
    validates :email, presence: true
  end

  # rubocop:disable Metrics/BlockLength, Layout/MultilineHashBraceLayout
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
      transition registered: :incompleted
    end

    event :ineligible do
      transition waiting: :registered
    end

    state :registered

    state :waiting do
      validates :sufficient_eligible_prs?, inclusion: {
        in: [true], message: 'user does not have sufficient eligible prs' }
    end

    state :completed do
      validates :won_hacktoberfest?, inclusion: {
        in: [true], message: 'user has not met all winning conditions' }
    end

    state :incompleted do
      validates :hacktoberfest_ended?, inclusion: {
        in: [true], message: 'hacktoberfest has not yet ended' }
    end
  end
  # rubocop:enable Metrics/BlockLength, Layout/MultilineHashBraceLayout

  protected

  def score
    pr_service = PullRequestService.new(self)
    pr_service.score
  end

  def score_mature_prs
    pr_service = PullRequestService.new(self)
    pr_service.count_mature_prs
  end

  def sufficient_eligible_prs?
    score >= 4
  end

  def won_hacktoberfest?
    score_mature_prs >= 4
  end

  def hacktoberfest_ended?
    Date.parse(ENV.fetch('END_DATE')).past?
  end
end
