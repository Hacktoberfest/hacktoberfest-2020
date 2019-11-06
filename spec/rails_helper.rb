# frozen_string_literal: true

# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
require 'active_support/core_ext/numeric/time'

ENV['RAILS_ENV'] ||= 'test'
ENV['START_DATE'] = 2.weeks.ago.to_s
ENV['END_DATE'] = 2.weeks.from_now.to_s

require File.expand_path('../config/environment', __dir__)
# Prevent database truncation if the environment is production
abort('The Rails env is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'sidekiq/testing'
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

def user_github_token
  ENV.fetch('TEST_USER_GITHUB_TOKEN') { SecureRandom.hex(20) }
end

def segment_write_key
  ENV.fetch('SEGMENT_WRITE_KEY') { SecureRandom.hex(20) }
end

unless ENV['TEST_USER_GITHUB_TOKEN']
  puts <<~ENDWARNING

    *************************************************************************

    No environment variable `TEST_USER_GITHUB_TOKEN` variable is defined!

    Ignore this message if tests are running on CI or no new tests are being
    written, as successful network responses will be replayed by VCR.

    `TEST_USER_GITHUB_TOKEN` will likely need to be set in the `.env` file to
    a valid user token in order to record new successful network requests.

    *************************************************************************

  ENDWARNING
end

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.include AuthenticationHelper
  config.include PullRequestFilterHelper
  config.include GraphqlClientHelper

  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end
