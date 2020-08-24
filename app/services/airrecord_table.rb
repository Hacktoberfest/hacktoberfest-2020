# frozen_string_literal: true

class AirrecordTable
  attr_accessor :api_key, :app_id

  def initialize
    @api_key = ENV.fetch('AIRTABLE_API_KEY')
    @app_id = ENV.fetch('AIRTABLE_APP_ID')
  end

  def faraday_connection
    @faraday_connection ||= Faraday.new(
      url: 'https://api.airtable.com',
      headers: {
        'Authorization' => "Bearer #{api_key}",
        'User-Agent' => "Airrecord/#{Airrecord::VERSION}",
        'X-API-VERSION' => '0.1.0'
      },
      request: {
        params_encoder: Airrecord::QueryString,
        open_timeout: 3,
        timeout: 10
      }
    ) do |conn|
      unless Rails.configuration.cache_store == :null_store
        conn.response :caching do
          ActiveSupport::Cache.lookup_store(
            *Rails.configuration.cache_store,
            namespace: 'airtable',
            expires_in: 1800 # 30 minutes in seconds
          )
        end
      end
      conn.request :airrecord_rate_limiter, requests_per_second: 5
      conn.adapter :net_http_persistent
    end
  end

  def table(table_name)
    Airrecord.table(api_key, app_id, table_name).tap do |at|
      at.client.connection = faraday_connection
    end
  end

  def all_records(table_name)
    if Hacktoberfest.airtable_key_present?
      table(table_name).all
    else
      log_airtable_warning
      AirtablePlaceholderService.call(table_name)
    end
  end

  def log_airtable_warning
    Rails.logger.warn '===> No AIRTABLE ENV keys are set'
  end
end
