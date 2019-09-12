# frozen_string_literal: true

module TryUserTransitionFromRegisteredService
  def self.call(user)
    user.wait
  end
end
