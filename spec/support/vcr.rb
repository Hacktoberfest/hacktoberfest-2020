# frozen_string_literal: true

require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr'
  c.hook_into :webmock
  c.configure_rspec_metadata!

  c.filter_sensitive_data('<TEST_USER_GITHUB_TOKEN>') do
    user_github_token
  end

  c.filter_sensitive_data('<TEST_SEGMENT_WRITE_KEY>') do
    segment_write_key
  end

  c.filter_sensitive_data('<TEST_AIRTABLE_API_KEY>') do
    ENV.fetch('AIRTABLE_API_KEY')
  end

  c.filter_sensitive_data('<TEST_AIRTABLE_APP_ID>') do
    ENV.fetch('AIRTABLE_APP_ID')
  end
end
