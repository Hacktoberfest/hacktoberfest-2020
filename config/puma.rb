# frozen_string_literal: true

threads_count = ENV.fetch('RAILS_MAX_THREADS') { 5 }
threads threads_count, threads_count
workers 16
worker_timeout 50

port ENV.fetch('PORT') { 3000 }

preload_app!

before_fork do
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.connection.disconnect!
end

after_worker_fork do
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.establish_connection
end
