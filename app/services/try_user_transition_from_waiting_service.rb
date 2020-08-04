# frozen_string_literal: true

module TryUserTransitionFromWaitingService
  def self.call(user)
    return unless user.state == 'waiting'

    return if user.complete

    user.insufficient
  end
end
