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
        expect(response.status).to_not eq(404)
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
