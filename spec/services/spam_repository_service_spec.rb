# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SpamRepositoryService do
  describe '.call' do
    context 'repository is spam', :vcr do
      it 'returns true' do
        expect(SpamRepositoryService.call(152433556)).to eq(true)
      end
    end

    context 'repository is not spam' do
      it 'returns false', :vcr do
        expect(SpamRepositoryService.call(123)).to eq(false)
      end
    end
  end
end
