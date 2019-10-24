# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SpamRepositoryService do
  describe '.call' do
    context 'repository is spam' do
      before do
        spam_repository = FactoryBot.create(:spam_repository)
      end
      it 'returns true' do
        expect(SpamRepositoryService.call(spam_repository.id)).to eq(true)
      end
    end

    context 'repository is not spam' do
      it 'returns false' do
        expect(SpamRepositoryService.call(123)).to eq(false)
      end
    end
  end
end
