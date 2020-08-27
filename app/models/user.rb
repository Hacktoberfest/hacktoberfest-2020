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
      transition registered: :waiting,
                 if: ->(user) { user.sufficient_waiting_or_eligible_prs? }
    end

    event :complete do
      transition waiting: :completed,
                 if: ->(user) { user.sufficient_eligible_prs? }
    end

    event :insufficient do
      transition waiting: :registered,
                 unless: ->(user) { user.sufficient_waiting_or_eligible_prs? }
    end

    event :won do
      transition completed: :won_shirt, if: ->(user) { user.shirt_coupon }
      transition completed: :won_sticker, if: ->(user) { user.sticker_coupon }
    end

    event :incomplete do
      transition registered: :incompleted,
                 unless: ->(user) { user.any_waiting_or_is_eligible? }
    end

    event :gifted do
      transition incompleted: :gifted_sticker,
                 if: ->(user) { user.sticker_coupon }
    end

    event :retry_complete do
      transition incompleted: :completed
    end

    event :ban do
      transition %i[registered waiting] => :banned
    end

    event :unban do
      transition banned: :registered
    end

    state all - [:new] do
      validates :terms_acceptance, acceptance: true
      validates :email, presence: true
    end

    state all - [:won_shirt] do
      validates :shirt_coupon, absence: true
    end

    state all - %i[won_sticker gifted_sticker] do
      validates :sticker_coupon, absence: true
    end

    state all - %i[new registered waiting] do
      validates :receipt, presence: true
    end

    state :registered do
      validates :email, inclusion: { in: :github_emails }
    end

    state :waiting do
      validates :sufficient_waiting_or_eligible_prs?, inclusion: {
        in: [true],
        message: 'user does not have sufficient waiting or eligible prs' }
    end

    state :completed do
      validates :sufficient_eligible_prs?, inclusion: {
        in: [true],
        message: 'user does not have sufficient eligible prs' }

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
      validates :any_waiting_prs?, inclusion: {
        in: [false], message: 'user has waiting prs' }
      validates :sufficient_eligible_prs?, inclusion: {
        in: [false], message: 'user has too many sufficient eligible prs' }

      def gift
        assign_coupon
        gifted
      end
    end

    state :gifted_sticker do
      validates :sticker_coupon, presence: true
    end

    before_transition do |user, _transition|
      UserPullRequestSegmentUpdaterService.call(user)
    end

    after_transition do |user, transition|
      UserStateTransitionSegmentService.call(user, transition)
    end

    before_transition to: %i[completed incompleted] do |user, _transition|
      user.receipt = user.scoring_pull_requests_receipt
    end

    after_transition to: :waiting do |user, _transition|
      # Some users might be able to go direct to winning
      #  if their PRs are already all a week old
      user.complete
    end

    after_transition to: :completed do |user, _transition|
      user.win
    end

    after_transition to: :banned do |user, _transition|
      user.moderator_banned = true
      user.moderator_banned_at = Date.current
      user.save!
    end

    after_transition to: :unbanned do |user, _transition|
      user.moderator_banned = false
      user.moderator_banned_at = Date.current
      user.save!
      TryUserTransitionService.call(user)
    end
  end
  # rubocop:enable Metrics/BlockLength, Layout/MultilineHashBraceLayout

  def pull_requests
    pull_request_service.all
  end

  def spam_repo_pull_requests_count
    pull_request_service.spam_repo_prs.count
  end

  def invalid_label_pull_requests_count
    pull_request_service.invalid_label_prs.count
  end

  def waiting_pull_requests_count
    pull_request_service.waiting_prs.count
  end

  def eligible_pull_requests_count
    pull_request_service.eligible_prs.count
  end

  def waiting_or_eligible_pull_requests_count
    waiting_pull_requests_count + eligible_pull_requests_count
  end

  def sufficient_waiting_or_eligible_prs?
    waiting_or_eligible_pull_requests_count >= 4
  end

  def sufficient_eligible_prs?
    eligible_pull_requests_count >= 4
  end

  def any_waiting_prs?
    waiting_pull_requests_count.positive?
  end

  def any_waiting_or_is_eligible?
    any_waiting_prs? || sufficient_eligible_prs?
  end

  def score
    score = waiting_or_eligible_pull_requests_count
    score > 4 ? 4 : score
  end

  delegate :scoring_pull_requests, :non_scoring_pull_requests,
           :scoring_pull_requests_receipt, to: :pull_request_service

  def hacktoberfest_ended?
    Hacktoberfest.end_date.past?
  end

  def completed_or_won?
    completed? || won_shirt? || won_sticker?
  end

  def check_flagged_state
    should_flag = should_be_flagged?

    return if system_flagged == should_flag

    self.system_flagged_at = Date.current
    self.system_flagged = should_flag
    save!
  end

  delegate :assign_coupon, to: :coupon_service

  private

  def should_be_flagged?
    invalid_count = invalid_label_pull_requests_count + spam_repo_pull_requests_count
    total_count = pull_requests.count

    total_count >= 8 && invalid_count.to_f / total_count >= 0.75
  end

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
