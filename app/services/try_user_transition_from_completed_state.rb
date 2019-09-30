# frozen_string_literal: true

module TryUserTransitionFromCompletedService
  def self.call(user)
    return unless user.state == 'completed'

    user.win
  end
end
