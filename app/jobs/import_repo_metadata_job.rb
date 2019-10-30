# frozen_string_literal: true

class ImportRepoMetadataJob
  include Sidekiq::Worker
  sidekiq_options queue: :default, retry: 5

  def perform(repo_id)
    ImportRepoMetadataService.call(repo_id)
  end
end
