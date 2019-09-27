# frozen_string_literal: true

class UserTransitionJob
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)
    TryUserTransitionService.call(user)
  end
end
