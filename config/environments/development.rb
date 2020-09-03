# frozen_string_literal: true

Rails.application.configure do
  config.cache_classes = false

  config.eager_load = false

  config.consider_all_requests_local = true

  # logger           = ActiveSupport::Logger.new(STDOUT)
  # logger.formatter = config.log_formatter
  # config.logger    = ActiveSupport::TaggedLogging.new(logger)

  config.log_level = :debug

  if ENV['DALLI_SERVER'].presence
    config.cache_store = :dalli_store, *ENV['DALLI_SERVER']
    config.action_controller.perform_caching = true
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end

  config.active_storage.service = :local

  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  config.active_support.deprecation = :log

  config.active_record.migration_error = :page_load

  config.active_record.verbose_query_logs = true

  config.assets.debug = true

  config.assets.quiet = true

  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
end
