# frozen_string_literal: true

module TryUserTransitionFromWaitingService
  def self.call(user)
    return unless user.state == 'waiting'

    return if user.complete

    user.ineligible if user.eligible_pull_requests_count < 4
  end
end
