# frozen_string_literal: true

module TryUserTransitionFromWaitingService
  def self.call(user)
    return unless user.state == 'waiting'

    return if user.complete

    user.ineligible if user.score < 4
  end
end
