# frozen_string_literal: true

class User < ApplicationRecord
  has_one :sticker_coupon
  has_one :shirt_coupon
  validate :only_one_coupon
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

    state all - [:new] do
      validates :terms_acceptance, acceptance: true
      validates :email, presence: true
      validates_inclusion_of :email, in: :github_emails
    end

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

    before_transition do |user, _transition|
      UserPullRequestSegmentUpdaterService.call(user)
    end

    after_transition do |user, transition|
      UserStateTransitionSegmentService.call(user, transition)
    end

    after_transition to: :waiting, do: :update_waiting_since
  end
  # rubocop:enable Metrics/BlockLength, Layout/MultilineHashBraceLayout

  def pull_requests
    pull_request_service.all
  end

  def score
    score = eligible_pull_requests_count
    score > 4 ? 4 : score
  end

  protected

  def only_one_coupon
    if self.shirt_coupon && self.sticker_coupon
      errors.add(:user, "can only have one type of coupon")
    end
  end

  def eligible_pull_requests_count
    pull_request_service.eligible_prs.count
  end

  def timeline_pull_requests
    pull_request_service.timeline_pull_requests
  end

  def sufficient_eligible_prs?
    eligible_pull_requests_count >= 4
  end

  def won_hacktoberfest?
    sufficient_eligible_prs? && waiting_for_week?
  end

  def hacktoberfest_ended?
    Hacktoberfest.end_date.past?
  end

  def update_waiting_since
    update(waiting_since: DateTime.now)
  end

  def waiting_for_week?
    return false if waiting_since.nil?
    waiting_since < (Date.today - 7.days)
  end

  private

  def github_emails
    UserEmailService.new(self).emails
  end

  def pull_request_service
    @pull_request_service ||= PullRequestService.new(self)
  end
end
