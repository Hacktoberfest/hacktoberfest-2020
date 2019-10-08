# frozen_string_literal: true

HealthCheck.setup do |config|
  # uri prefix (no leading slash)
  config.uri = 'healthy'

  # Text output upon success
  config.success = 'success'

  # Timeout in seconds used when checking smtp server
  config.smtp_timeout = 30.0

  # http status code used when plain text error message is output
  # Set to 200 if you want your want to distinguish between partial (text does not include success) and
  # total failure of rails application (http status of 500 etc)

  config.http_status_for_error_text = 500

  # http status code used when an error object is output (json or xml)
  # Set to 200 if you want your want to distinguish between partial (healthy property == false) and
  # total failure of rails application (http status of 500 etc)

  config.http_status_for_error_object = 500

  # bucket names to test connectivity - required only if s3 check used, access permissions can be mixed
  # config.buckets = {'bucket_name' => [:R, :W, :D]}

  # You can customize which checks happen on a standard health check, eg to set an explicit list use:
  config.standard_checks = %w[database sidekiq-redis mem_cache]

  # Or to exclude one check:
  # config.standard_checks -= [ 'emailconf' ]

  # You can set what tests are run with the 'full' or 'all' parameter
  # config.full_checks = ['database', 'migrations', 'custom', 'email', 'cache', 'redis', 'resque-redis', 'sidekiq-redis', 's3']

  # Add one or more custom checks that return a blank string if ok, or an error message if there is an error
  # config.add_custom_check do
  #   CustomHealthCheck.perform_check # any code that returns blank on success and non blank string upon failure
  # end

  # Add another custom check with a name, so you can call just specific custom checks. This can also be run using
  # the standard 'custom' check.
  # You can define multiple tests under the same name - they will be run one after the other.
  config.add_custom_check('mem_cache') do
    # Success if mem_mache is not being used
    if (mem_cache_url = ENV.fetch('MEM_CACHE_URL', nil))
      if Rails.cache.stats.fetch(mem_cache_url)&.fetch('pid').present?
        ''
      else
        "[mem_cache: error connecting to: `#{mem_cache_url}`]"
      end
    else
      ''
    end
  end

  # max-age of response in seconds
  # cache-control is public when max_age > 1 and basic_auth_username is not set
  # You can force private without authentication for longer max_age by
  # setting basic_auth_username but not basic_auth_password
  config.max_age = 1

  # Protect health endpoints with basic auth
  # These default to nil and the endpoint is not protected
  # config.basic_auth_username = 'my_username'
  # config.basic_auth_password = 'my_password'

  # Whitelist requesting IPs
  # Defaults to blank and allows any IP
  # config.origin_ip_whitelist = %w(123.123.123.123)

  # http status code used when the ip is not allowed for the request
  config.http_status_for_ip_whitelist_error = 403

  # When redis url is non-standard
  # We use sidekiq redis instead to check for this
  # config.redis_url = ENV.fetch('HACKTOBERFEST_REDIS_URL', nil)

  # Disable the error message to prevent /health_check from leaking
  # sensitive information
  # config.include_error_in_response_body = false
end
