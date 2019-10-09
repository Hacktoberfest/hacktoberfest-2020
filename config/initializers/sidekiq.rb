# frozen_string_literal: true

# Sidekiq configuration
# See: https://github.com/mperham/sidekiq

# Redis config shared between client and server
if (redis_url = ENV.fetch('HACKTOBERFEST_REDIS_URL', nil))
  REDIS_CONFIG = {
    url: redis_url,
    password: ENV.fetch('HACKTOBERFEST_REDIS_PASSWORD', nil)
    # namespace: #Consider using a namespace to separate sidekiq fro app cache
  }.freeze
end

# Custom Error message reporting a job death to airbrake
module Sidekiq
  class JobDeathError < StandardError
    def initialize(job, exec)
      @job = job
      @ex = exec
    end

    def message
      "#{@job['class']} #{@job['jid']} died with error #{@ex.message}."
    end
  end
end

Sidekiq.configure_server do |config|
  config.redis = REDIS_CONFIG if defined?(REDIS_CONFIG)

  # https://github.com/mperham/sidekiq/wiki/Reliability#using-super_fetch
  config.super_fetch!

  # Periodic job setup
  # See: https://github.com/mperham/sidekiq/wiki/Ent-Periodic-Jobs
  config.periodic do |mgr|
    # Every hour
    mgr.register(
      '0 */2 * * *',
      TransitionAllUsersJob,
      retry: 3,
      queue: :critical
    )
    # Every day at 3AM
    mgr.register('0 3 * * *', UpdateAllIssuesJob, retry: 3, queue: :critical)
    # Every day at 5AM
    mgr.register(
      '0 5 * * *',
      UpdateAllIssuesQualityJob,
      retry: 3,
      queue: :default
    )
    # Every hour. 1 hour max latency when updating banned repos in airtable
    mgr.register(
      '0 * * * *',
      BanAllReposJob,
      retry: 3,
      queue: :default
    )
  end

  config.death_handlers << lambda { |job, ex|
    error = Sidekiq::JobDeathError.new(job, ex)
    Airbrake.notify(error) do |notice|
      notice[:context][:component] = 'sidekiq'
    end
  }
end

Sidekiq.configure_client do |config|
  config.redis = REDIS_CONFIG if defined?(REDIS_CONFIG)
end
