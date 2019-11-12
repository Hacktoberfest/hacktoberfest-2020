# frozen_string_literal: true

module TryUserTransitionService
  def self.call(user)
    GithubErrorHandler.with_error_handling(user) do
      case user.state
      when 'registered'
        TryUserTransitionFromRegisteredService.call(user)
      when 'waiting'
        TryUserTransitionFromWaitingService.call(user)
      when 'completed'
        TryUserTransitionFromCompletedService.call(user)
      end
    end
  end
end
