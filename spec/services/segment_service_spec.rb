# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SegmentService do
  let(:user) { FactoryBot.create(:user) }

  describe '#identify' do
    context 'successful request' do
      let(:segment) { SegmentService.new(user) }

      it 'makes the correct POST request', :vcr do
        res = segment.identify(traits: { "test-trait": true })
        expect(res.status).to eq(200)
      end
    end

    context 'failed request' do
      let(:segment) { SegmentService.new(user) }

      before do
        stub_request(:post, "#{SegmentService::SEGMENT_API_URL}/identify")
          .and_return(status: 404)
      end

      it 'raises the appropriate error', :vcr do
        expect do
          segment.identify(traits: { "test-trait": true })
        end.to raise_error(Faraday::ClientError)
      end
    end
  end

  describe '#track' do
    context 'successful request' do
      let(:segment) { SegmentService.new(user) }

      it 'makes the correct POST request', :vcr do
        res = segment.track('event')
        expect(res.status).to eq(200)
      end
    end

    context 'failed request' do
      let(:segment) { SegmentService.new(user) }

      before do
        stub_request(:post, "#{SegmentService::SEGMENT_API_URL}/track")
          .and_return(status: 404)
      end

      it 'raises the appropriate error', :vcr do
        expect do
          segment.track('event')
        end.to raise_error(Faraday::ClientError)
      end
    end
  end
end
