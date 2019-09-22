# frozen_string_literal: true

module TryUserTransitionFromRegisteredService
  def self.call(user)
    return unless user.state == 'registered'

    user.update(waiting_since: DateTime.now)
    user.wait
  end
end
