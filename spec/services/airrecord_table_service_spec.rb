# frozen_string_literal: true

require 'rails_helper'

describe AirrecordTable do
  # rubocop:disable Metrics/LineLength
  AIRTABLE_API = 'https://airtable.com/api'

  context 'the call to the API is successful' do
    let(:airrecord_table) { AirrecordTable.new }

    it 'returns success status' do
      VCR.use_cassette 'AirrecordTable/the_call_to_the_API_is_successful/returns_success_status' do
        response = airrecord_table.faraday_connection.get
        expect(response.status).to eq(302)
      end
    end

    it 'returns a data hash' do
      VCR.use_cassette 'AirrecordTable/the_call_to_the_API_is_successful/returns_a_data_hash', match_requests_on: [:host] do
        records = airrecord_table.all_records('FAQs')
        expect(records.first.fields).to have_key('Question')
      end
    end
  end

  context 'the call to the API is unsuccessful' do
    let(:airrecord_table) { AirrecordTable.new }

    it 'returns a non 200 code' do
      VCR.use_cassette 'AirrecordTable/the_call_to_the_API_is_unsuccessful/returns_a_non_200_code' do
        url = AIRTABLE_API + 'not-a-real-url'
        response = airrecord_table.faraday_connection(url).get
        expect(response.status).to eq(404)
      end
    end

    it 'creates a mock table object' do
      table = AirtablePlaceholderService.call('FAQs')
      expect(table.first).to have_key('Question')
    end
  end
  # rubocop:enable Metrics/LineLength
end
