# frozen_string_literal: true

require 'omniauth'
require 'factory_bot'

FactoryBot.definition_file_paths = ["./spec/factories"]
FactoryBot.find_definitions
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # rspec-mocks config goes here.
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  OmniAuth.config.test_mode = true
end
