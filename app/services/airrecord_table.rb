# frozen_string_literal: true

class AirrecordTable
  attr_accessor :api_key, :app_id

  def initialize
    @api_key = ENV['AIRTABLE_API_KEY']
    @app_id = ENV['AIRTABLE_APP_ID']
  end

  def faraday_connection
    @faraday_connection ||= Faraday.new(
      url: 'https://api.airtable.com',
      headers: {
        'Authorization' => "Bearer #{api_key}",
        'User-Agent' => "Airrecord/#{Airrecord::VERSION}",
        'X-API-VERSION' => '0.1.0'
      },
      request: { params_encoder: Airrecord::QueryString }
    ) do |conn|
      unless Rails.configuration.cache_store == :null_store
        conn.response :caching do
          ActiveSupport::Cache.lookup_store(
            *Rails.configuration.cache_store,
            namespace: 'airtable',
            expires_in: 300 # 5 minutes in seconds
          )
        end
      end
      conn.request :airrecord_rate_limiter, requests_per_second: 5
      conn.adapter :net_http_persistent
    end
  end



  def all_records(table_name)
    if airtable_key_present?
      Airrecord.table(api_key, app_id, table_name).tap do |at|
        at.client.connection = faraday_connection
      end.all
    else
      log_airbrake_warning
      if table_name == 'Meetups' do
        PlaceholderEventsService.call
      elsif table_name == 'FAQ' do
        PlaceholderFaqService.call
      end
  end

  def airtable_key_present?
    @api_key.present?
  end

  def log_airtable_warning
    Rails.logger.warn '===> No AIRTABLE ENV keys are set'
  end
end
