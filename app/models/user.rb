# frozen_string_literal: true

# rubocop:disable Metrics/ClassLength
class User < ApplicationRecord
  has_one :sticker_coupon, dependent: :restrict_with_exception
  has_one :shirt_coupon, dependent: :restrict_with_exception

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

    event :won do
      transition completed: :won_shirt, if: ->(user) { user.shirt_coupon }
      transition completed: :won_sticker, if: ->(user) { user.sticker_coupon }
    end

    event :incomplete do
      transition registered: :incompleted
    end

    event :ineligible do
      transition waiting: :registered,
                 unless: ->(user) { user.sufficient_eligible_prs? }
    end

    state all - [:new] do
      validates :terms_acceptance, acceptance: true
      validates :email, presence: true
    end

    state all - [:won_shirt] do
      validates :shirt_coupon, absence: true
    end

    state all - [:won_sticker] do
      validates :sticker_coupon, absence: true
    end

    state all - %i[new registered waiting] do
      validates :receipt, presence: true
    end

    state :registered do
      validates :email, inclusion: { in: :github_emails }
    end

    state :waiting do
      validates :sufficient_eligible_prs?, inclusion: {
        in: [true], message: 'user does not have sufficient eligible prs' }
    end

    state :completed do
      validates :won_hacktoberfest?, inclusion: {
        in: [true], message: 'user has not met all winning conditions' }

      def win
        assign_coupon
        won
      end
    end

    state :won_shirt do
      validates :shirt_coupon, presence: true
    end

    state :won_sticker do
      validates :sticker_coupon, presence: true
    end

    state :incompleted do
      validates :hacktoberfest_ended?, inclusion: {
        in: [true], message: 'hacktoberfest has not yet ended' }
      validates :sufficient_eligible_prs?, inclusion: {
        in: [false], message: 'user has too many sufficient eligible prs' }
    end

    before_transition do |user, _transition|
      UserPullRequestSegmentUpdaterService.call(user)
    end

    after_transition do |user, transition|
      UserStateTransitionSegmentService.call(user, transition)
    end

    before_transition to: %i[completed incompleted] do |user, _transition|
      user.receipt = user.scoring_pull_requests
    end

    after_transition to: :waiting, do: :update_waiting_since

    after_transition to: :completed do |user, _transition|
      user.win
    end
  end
  # rubocop:enable Metrics/BlockLength, Layout/MultilineHashBraceLayout

  def pull_requests
    pull_request_service.all
  end

  def score
    score = eligible_pull_requests_count
    score > 4 ? 4 : score
  end

  def eligible_pull_requests_count
    pull_request_service.eligible_prs.count
  end

  delegate :scoring_pull_requests, :non_scoring_pull_requests,
           to: :pull_request_service

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

    waiting_since <= (Time.zone.now - 7.days)
  end

  def completed_or_won?
    completed? || won_shirt? || won_sticker?
  end

  delegate :assign_coupon, to: :coupon_service

  private

  def github_emails
    UserEmailService.new(self).emails
  end

  def only_one_coupon
    return unless shirt_coupon && sticker_coupon

    errors.add(:user, 'can only have one type of coupon')
  end

  def pull_request_service
    @pull_request_service ||= PullRequestService.new(self)
  end

  def coupon_service
    @coupon_service ||= CouponService.new(self)
  end
end
# rubocop:enable Metrics/ClassLength
