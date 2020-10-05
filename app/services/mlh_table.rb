# frozen_string_literal: true

class MlhTable
  attr_accessor :api_url

  def initialize
    @api_url = 'https://organize.mlh.io/api/v2/events?type=hacktoberfest-2020'
  end

  def faraday_connection
    @faraday_connection ||= Faraday.new(
      url: @api_url,
      request: {
        open_timeout: 3,
        timeout: 10
      }
    ) do |faraday|
      faraday.use Faraday::Response::RaiseError
      faraday.adapter Faraday.default_adapter
    end
    response = @faraday_connection.get
    unless Rails.configuration.cache_store == :null_store
      response.body do
        ActiveSupport::Cache.lookup_store(
          *Rails.configuration.cache_store,
          namespace: 'mlh',
          expires_in: 3.hours
        )
      end
    end
    response.body if response.success?
  rescue StandardError
    { 'data' => AirtablePlaceholderService.call('Meetups') }
  end

  def records
    if faraday_connection.is_a? String
      JSON.parse(faraday_connection)
    else
      faraday_connection
    end
  end
end
