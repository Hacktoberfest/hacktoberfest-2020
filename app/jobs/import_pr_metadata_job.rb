# frozen_string_literal: true

class ImportPrMetadataJob
  include Sidekiq::Worker
  sidekiq_options queue: :default, retry: 7

  def perform(user_id)
    user = User.find(user_id)

    ImportPrMetadataService.call(user)
  end
end
