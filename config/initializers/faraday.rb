# frozen_string_literal: true

module Hacktoberfest
  def self.client(*)
    Faraday.new do |faraday|
      faraday.use :http_cache, shared_cache: false, store:
        Rails.cache, logger: Rails.logger, serializer: Marshal
      faraday.response :raise_error
      faraday.adapter Faraday.default_adapter
    end
  end
end
