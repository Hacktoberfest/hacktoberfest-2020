# frozen_string_literal: true

Rails.application.configure do
  config.cache_classes = false

  config.eager_load = false

  config.consider_all_requests_local = true

  logger           = ActiveSupport::Logger.new(STDOUT)
  logger.formatter = config.log_formatter
  #config.logger    = ActiveSupport::TaggedLogging.new(logger)
  config.logger = ActiveSupport::Logger.new("log/#{Rails.env}.log")

  config.log_level = :debug

  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :file_store, Rails.root.join('tmp', 'cache', 'store')
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
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
