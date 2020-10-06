# frozen_string_literal: true

require 'rails_helper'

describe MlhTable do
  # rubocop:disable Metrics/LineLength
  MLH_API = 'https://organize.mlh.io/api/v2/events?type=hacktoberfest-2020'

  context 'the call to the API is successful' do
    let(:faraday) { Faraday.new }

    it 'returns a 200 status' do
      VCR.use_cassette 'MlhTable/the_call_to_the_API_is_successful/returns_a_200_status' do
        response = faraday.get(MLH_API)
        expect(response.status).to eq(200)
      end
    end

    it 'returns a data hash' do
      VCR.use_cassette 'MlhTable/the_call_to_the_API_is_successful/returns_a_200_status' do
        response = faraday.get(MLH_API)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response).to be_an_instance_of(Hash)
        expect(parsed_response).to have_key('data')
      end
    end
  end

  context 'the call to the API is unsuccessful' do
    let(:faraday) { Faraday.new }

    it 'returns a non 200 code' do
      VCR.use_cassette 'MlhTable/the_call_to_the_API_is_unsuccessful/returns_a_non_200_code' do
        response = faraday.get(MLH_API + 'not-a-real-url')
        expect(response.status).to eq(404)
      end
    end

    it 'creates a mock table object' do
      table = AirtablePlaceholderService.call('Meetups')
      expect(table.first).to have_key('attributes')
    end
  end
  # rubocop:enable Metrics/LineLength
end
