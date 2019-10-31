# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FetchSpamRepositoriesService do
  describe '.call' do
    let!(:existing_spam_repository) do
      FactoryBot.create(:spam_repository, github_id: 999)
    end

    before do
      allow(FetchSpamRepositoriesService)
        .to receive(:spam_repo_ids).and_return([123, 456, 789])

      FetchSpamRepositoriesService.call
    end

    it 'ends with the correct number of SpamRepository records' do
      expect(SpamRepository.count).to eq(3)
    end

    it 'updates SpamRepository records to contain the exact records' do
      expect(SpamRepository.pluck(:github_id).sort).to eq([123, 456, 789])
    end

    it 'removes unnecessary SpamRepository records' do
      expect(SpamRepository.where(github_id: existing_spam_repository.github_id).first).to eq(nil)
    end
  end
end
