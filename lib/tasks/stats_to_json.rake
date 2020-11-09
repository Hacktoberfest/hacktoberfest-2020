# frozen_string_literal: true

def custom_database_connection
  return unless ENV['HACKTOBERFEST_DATABASE_CUSTOM']

  # Support modifying the DB connection to allow remote export.
  # Setting these env vars without this method works fine,
  #  except the vars that need casting to integers.
  conn_config = ActiveRecord::Base.connection_config
  conn_config[:database] = ENV['HACKTOBERFEST_DATABASE_NAME']
  conn_config[:username] = ENV['HACKTOBERFEST_DATABASE_USERNAME']
  conn_config[:password] = ENV['HACKTOBERFEST_DATABASE_PASSWORD']
  conn_config[:host] = ENV['HACKTOBERFEST_DATABASE_HOST']
  conn_config[:port] = ENV['HACKTOBERFEST_DATABASE_PORT']&.to_i
  conn_config[:pool] = ENV['HACKTOBERFEST_DATABASE_POOL_SIZE']&.to_i
  conn_config[:timeout] = ENV['HACKTOBERFEST_DATABASE_TIMEOUT']&.to_i
  ActiveRecord::Base.establish_connection conn_config
  p conn_config
end

namespace :export do
  desc 'Export all UserStats to a JSON file'
  task user_stats: :environment do
    custom_database_connection
    JsonForUserStatsService.call
  end

  desc 'Export all PRStats to a JSON file'
  task pr_stats: :environment do
    custom_database_connection
    JsonForPrStatsService.call
  end

  desc 'Export all RepoStats to a JSON file'
  task repo_stats: :environment do
    custom_database_connection
    JsonForRepoStatsService.call
  end
end
