# frozen_string_literal: true

class ImportUserMetadataJob
  include Sidekiq::Worker
  sidekiq_options queue: :bulk, retry: 7

  def perform(user_id)
    user = User.find(user_id)
    return unless TokenValidatorService.new(user.provider_token).valid?

    ImportUserMetadataService.call(user_id)
  end
end
