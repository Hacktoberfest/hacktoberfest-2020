# frozen_string_literal: true

namespace :export do
  desc 'Export all UserStats to a JSON file'
  task user_stats: :environment do
    JsonForUserStatsService.call
  end

  desc 'Export all PRStats to a JSON file'
  task pr_stats: :environment do
    JsonForPrStatsService.call
  end

  desc 'Export all RepoStats to a JSON file'
  task repo_stats: :environment do
    JsonForRepoStatsService.call
  end
end
