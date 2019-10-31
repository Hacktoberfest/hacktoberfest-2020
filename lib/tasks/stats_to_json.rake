# frozen_string_literal: true

namespace :export do
  desc 'Export all UserStats to a csv'
  task user_stats: :environment do
    CsvForUserStatsService.call
  end

  desc 'Export all PRStats to a csv'
  task pr_stats: :environment do
    CsvForPrStatsService.call
  end

  desc 'Export all RepoStats to a csv'
  task repo_stats: :environment do
    JsonForRepoStatsService.call
  end
end
