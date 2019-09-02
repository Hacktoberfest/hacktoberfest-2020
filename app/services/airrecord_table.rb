# frozen_string_literal: true

class AirrecordTable
  attr_accessor :api_key, :app_id

  def initialize
    @api_key = ENV['AIRTABLE_API_KEY']
    @app_id = ENV['AIRTABLE_APP_ID']
  end

  def faraday_connection
    @connection ||= Faraday.new(
      url: 'https://api.airtable.com',
      headers: {
        'Authorization' => "Bearer #{api_key}",
        'User-Agent' => "Airrecord/#{Airrecord::VERSION}",
        'X-API-VERSION' => '0.1.0'
      },
      request: { params_encoder: Airrecord::QueryString }
    ) do |conn|
      conn.use :http_cache, store: Rails.cache, logger:
      Rails.logger, serializer: Marshal
      conn.request :airrecord_rate_limiter, requests_per_second: 5
      conn.adapter :net_http_persistent
    end
  end

  def table(table_name)
    Airrecord.table(api_key, app_id, table_name).tap do |at|
      at.client.connection = faraday_connection
    end
  end
end
