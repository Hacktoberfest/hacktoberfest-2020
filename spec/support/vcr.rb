# frozen_string_literal: true

require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr'
  c.hook_into :webmock
  c.configure_rspec_metadata!

  vars_to_obscure = [
    'TEST_USER_GITHUB_TOKEN',
    'GITHUB_CLIENT_SECRET',
    'GITHUB_CLIENT_ID',
    'SEGMENT_WRITE_KEY',
    'AIRTABLE_API_KEY',
    'AIRTABLE_APP_ID'
  ]

  vars_to_obscure.map do |var|
    obfuscation_text = var.dup
    obfuscation_text.prepend('<TEST_').concat('>')

    c.filter_sensitive_data(obfuscation_text) do
      ENV.fetch(var)
    end
  end
end
