# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PullRequestFilterService' do
  let(:array) { [] }
  let(:pull_request_filter) { PullRequestFilterService.new(array) }

  describe '.new' do
    context 'valid arguments' do
      it 'returns a PullRequestFilterService' do
        expect(pull_request_filter).to_not be(nil)
      end
    end

    context 'invalid arguments' do
      it 'raises an error ' do
        expect { PullRequestFilterService.new(123, 'abc') }.to
        raise_error(ArgumentError)
      end
    end

    context 'no arguments provided' do
      it 'raises an error ' do
        expect { PullRequestFilterService.new }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#filter' do
    context 'given an array of 4 pull requests' do
      context 'pull requests with valid dates and valid labels' do
        before do
          let(:result) { mock_pull_request_filter('valid array') }
        end

        it 'filters and returns all 4 pull requests' do
          expect(result.length).to eq(4)
        end
      end

      context 'pull requests with 2 invalid dates & valid labels' do
        before do
          let(:result) { mock_pull_request_filter('invalid dates') }
        end

        it 'filters and returns 2 of the pull requests' do
          expect(result.length).to eq(2)
        end
      end

      context 'pull_requests with valid dates & 2 invalid labels' do
        before do
          let(:result) { mock_pull_request_filter('invalid label') }
        end

        it 'filters and returns 2 of the pull requests' do
          expect(result.length).to eq(2)
        end
      end

      context 'pull_requests with 4 invalid dates & invalid labels' do
        before do
          let(:result) { mock_pull_request_filter('invalid dates & label') }
        end

        it 'filters and returns an empty array' do
          expect(result.length).to eq(0)
        end
      end
    end
  end
end
