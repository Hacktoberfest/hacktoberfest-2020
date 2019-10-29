# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SpamRepositoryService do
  describe '.call' do
    context 'repository is spam' do
      let!(:spam_repository) do
        FactoryBot.create(:spam_repository, github_id: 123_456)
      end

      it 'returns true' do
        expect(SpamRepositoryService.call(123_456)).to eq(true)
      end
    end

    context 'repository is not spam' do
      it 'returns false' do
        expect(SpamRepositoryService.call(123)).to eq(false)
      end
    end
  end
end
