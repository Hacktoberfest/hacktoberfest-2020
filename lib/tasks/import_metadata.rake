# frozen_string_literal: true

namespace :github do
  desc 'Import all github related metadata to the tb'
  task import_metadata: :environment do
    ImportAllMetadataJob.perform_async
  end
end
