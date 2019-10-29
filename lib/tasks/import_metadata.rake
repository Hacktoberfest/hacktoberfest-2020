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

  desc 'Count PRs per day and outpiut the results'
  task count_daily_prs: :environment do
    results = CountDailyPrsService.call

    puts results
  end
end
