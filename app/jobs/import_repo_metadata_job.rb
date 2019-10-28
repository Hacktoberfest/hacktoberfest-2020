# frozen_string_literal: true

class ImportRepoMetadataJob
  include Sidekiq::Worker
  sidekiq_options queue: :default, retry: 7

  def perform(user_id)
    user = User.find(user_id)

    ImportRepoMetadataService.call(user)
  end
end
