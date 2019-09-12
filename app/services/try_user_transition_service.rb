# frozen_string_literal: true

module TryUserTransitionService
  def self.call(user)
    case user.state
    when 'registered'
      TryUserTransitionFromRegisteredService.call(user)
    when 'waiting'
      TryUserTransitionFromWaitingService.call(user)
    end
  end
end
