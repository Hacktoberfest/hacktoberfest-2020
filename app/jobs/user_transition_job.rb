# frozen_string_literal: true

class UserTransitionJob
  include Sidekiq::Worker
  sidekiq_options queue: :bulk, retry: 7

  def perform(user_id)
    user = User.find(user_id)

    return unless TokenValidatorService.new(user.provider_token).valid?

    TryUserTransitionService.call(user)
  end
end
