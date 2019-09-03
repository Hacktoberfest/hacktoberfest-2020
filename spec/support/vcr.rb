# frozen_string_literal: true

require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr'
  c.hook_into :webmock
  c.configure_rspec_metadata!

  c.filter_sensitive_data("<TEST_USER_GITHUB_TOKEN>") do
    user_github_token
  end
end
