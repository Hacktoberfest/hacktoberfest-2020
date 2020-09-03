# frozen_string_literal: true

Rails.application.configure do
  config.cache_classes = true

  config.cache_store = :dalli_store, *ENV['DALLI_SERVER']

  config.eager_load = true

  config.consider_all_requests_local = false

  config.action_controller.perform_caching = true

  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  config.assets.js_compressor = Uglifier.new(harmony: true)

  config.assets.compile = false

  config.active_storage.service = :local

  config.log_level = ENV.fetch('RAILS_LOG_LEVEL', :info).to_sym

  config.log_tags = [:request_id]

  config.action_mailer.perform_caching = false

  config.i18n.fallbacks = true

  config.active_support.deprecation = :notify

  config.log_formatter = ::Logger::Formatter.new

  if ENV['RAILS_LOG_TO_STDOUT'].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  config.active_record.dump_schema_after_migration = false

  config.assets.precompile += %w(.svg)

  # Must include to get inline SVGs to work in deploy
  config.assets.css_compressor = :sass
end
