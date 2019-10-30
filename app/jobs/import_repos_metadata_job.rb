# frozen_string_literal: true

class ImportReposMetadataJob
  include Sidekiq::Worker
  sidekiq_options queue: :default, retry: 7

  def perform(user_id)
    user = User.find(user_id)

    ImportReposMetadataService.call(user)
  end
end
