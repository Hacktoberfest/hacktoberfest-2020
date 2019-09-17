# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SegmentService do
  let(:user) { FactoryBot.create(:user) }

  describe '#identify' do
    context 'successful request' do
      let(:segment) { SegmentService.new(user: user) }

      it 'makes the correct POST request', :vcr do
        res = segment.identify(traits: { "test-trait": true } )
        expect(res.status).to eq(200)
      end
    end

    context 'failed request' do
      let(:segment) { SegmentService.new(user: user) }

      before do
        stub_request(:post, "#{SegmentService::SEGMENT_API_URL}/identify")
          .and_return(status: 404)
      end

      it 'raises the appropriate error', :vcr do
        expect { 
          res = segment.identify(traits: { "test-trait": true } )
        }.to raise_error(Faraday::ClientError)
      end
    end

  end

  describe '#track' do
    context 'segment suceeds' do
      let(:segment) { SegmentService.new() }

    end

    context 'segment fails' do
      let(:segment) { SegmentService.new() }

      it 'raises the appropriate error' do
      end
    end
  end
end
