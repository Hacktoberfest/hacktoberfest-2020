# frozen_string_literal: true

class ImportOnePrMetadataJob
  include Sidekiq::Worker
  sidekiq_options queue: :default, retry: 5

  def perform(url)
    ImportOnePrMetadataService.call(url)
  end
end
