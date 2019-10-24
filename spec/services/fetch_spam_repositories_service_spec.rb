# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FetchSpamRepositoriesService do
  describe '.call' do
    context 'Airtable provides banned repos' do

      it 'creates the correct count of Spam Repositories in our db', :vcr do
        FetchSpamRepositoriesService.call

        expect(SpamRepository.count).to eq(133)
      end
    end
  end
end
