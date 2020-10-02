# frozen_string_literal: true

module TryUserTransitionService
  def self.call(user)
    case user.state
    when 'registered'
      TryUserTransitionFromRegisteredService.call(user)
    when 'waiting'
      TryUserTransitionFromWaitingService.call(user)
    when 'completed'
      TryUserTransitionFromCompletedService.call(user)
    end

    user.check_flagged_state
  end
end
