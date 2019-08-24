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
        expect { PullRequestFilterService.new(123, 'abc') }.to raise_error(ArgumentError)
      end
    end

    context 'no arguments provided' do
      it 'raises an error ' do
        expect { PullRequestFilterService.new }.to raise_error(ArgumentError)
      end
    end
  end

  describe 'filter'do

    context 'filters Prs with valid dates and valid labels' do
      it 'takes in an array with valid dates' do
        expect(original_array.length).to eq(filtered_array.length)
      end
    end

    context 'filters Prs with invalid dates & valid labels' do

    end

    context 'filters Prs with valid dates & invalid labels' do

    end

    context 'filters Prs with invalid dates & invalid labels' do

    end
  end
end
