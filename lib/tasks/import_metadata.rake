# frozen_string_literal: true

namespace :github do
  desc 'Import all github related metadata to the db'
  task import_metadata: :environment do
    job_count = ImportAllMetadataService.call

    puts "Enqueued #{job_count} jobs"
  end

  desc 'Import all PR related metadata to the db'
  task import_pr_metadata: :environment do
    job_count = ImportAllPrMetadataService.call

    puts "Enqueued #{job_count} jobs"
  end
end
