# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FetchSpamRepositoriesService do
  describe '.call' do
    context 'Airtable provides banned repos' do
      it 'creates the correct count of Spam Repositories in our db', :vcr do
        FetchSpamRepositoriesService.call

        expect(SpamRepository.count).to eq(133)
      end

      it 'removes SpamRepositories absent in airtable', :vcr do
        repo_absent_in_airtable = FactoryBot.create(:spam_repository)

        FetchSpamRepositoriesService.call

        expect(SpamRepository.count).to eq(133)
        expect(
          repo_absent_in_airtable.class.exists?(repo_absent_in_airtable.id)
        ).to eq(false)
      end
    end
  end
end
