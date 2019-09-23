# frozen_string_literal: true

module TryUserTransitionFromRegisteredService
  def self.call(user)
    return unless user.state == 'registered'

    user.wait
  end
end
