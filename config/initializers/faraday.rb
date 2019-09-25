# frozen_string_literal: true

module Hacktoberfest
  def self.client(*)
    Faraday.new do |faraday|
      faraday.response :raise_error
      faraday.adapter Faraday.default_adapter
    end
  end
end
