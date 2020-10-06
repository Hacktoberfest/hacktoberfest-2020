# frozen_string_literal: true

class MlhTable
  attr_accessor :api_url

  def initialize
    @api_url = 'https://organize.mlh.io/api/v2/events?type=hacktoberfest-2020'
  end

  def records
    data = validated_response rescue StandardError
    data || placeholder_response
  end

  private

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
      unless Rails.configuration.cache_store == :null_store
        faraday.response :caching do
          ActiveSupport::Cache.lookup_store(
              *Rails.configuration.cache_store,
              namespace: 'mlh',
              expires_in: 3.hours
          )
        end
      end
    end
    response = @faraday_connection.get
    response.body if response.success?
  end

  def parsed_response
    if faraday_connection.is_a? String
      JSON.parse(faraday_connection)
    else
      faraday_connection
    end
  end

  def validated_response
    data = parsed_response
    return unless data.present?
    return unless data.key?('data')
    return unless data['data'].kind_of?(Array)

    data
  end

  def placeholder_response
    { 'data' => AirtablePlaceholderService.call('Meetups') }
  end
end
