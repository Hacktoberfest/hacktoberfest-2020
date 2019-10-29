# frozen_string_literal: true

class ImportPRMetadataJob
  include Sidekiq::Worker
  sidekiq_options queue: :default, retry: 7

  def perform(user_id)
    user = User.find(user_id)

    ImportPRMetadataService.call(user)
  end
end
