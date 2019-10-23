# frozen_string_literal: true

namespace :github do
  desc 'Import all github related metadata to the db'
  task import_metadata: :environment do
    ImportAllMetadataService.call
  end
end
