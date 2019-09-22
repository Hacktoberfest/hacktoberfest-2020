# frozen_string_literal: true

require_relative 'boot'
require 'pry'
require 'rails/all'

Bundler.require(*Rails.groups)

module Hacktoberfest
  class Application < Rails::Application
    config.load_defaults 5.2
    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
    config.assets.paths << Rails.root.join('vendor', 'assets', 'javascripts')
    config.active_job.queue_adapter = :sidekiq
    config.require_master_key = false
  end
end
