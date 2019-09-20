# frozen_string_literal: true

class UserTransitionJob < ApplicationJob
  queue_as :transition

  def perform(user_id)
    user = User.find(user_id)
    TryUserTransitionService.call(user)
  end
end
