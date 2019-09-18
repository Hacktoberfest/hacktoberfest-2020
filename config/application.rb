# frozen_string_literal: true

require_relative 'boot'
require 'pry'
require 'rails/all'

Bundler.require(*Rails.groups)

module Hacktoberfest
  class Application < Rails::Application
    config.load_defaults 5.2
    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
  end
end
