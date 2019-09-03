# frozen_string_literal: true

require 'webmock/rspec'

RSpec.configure do |config|
  config.before(:each) do
    WebMock.reset!
    WebMock.disable_net_connect!
  end
end
