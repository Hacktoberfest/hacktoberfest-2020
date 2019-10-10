# frozen_string_literal: true

require 'rails_helper'

describe ReportAirtableUpdaterService do
  AIRTABLE_URI_REGEX = /https:\/\/api\.airtable\.com\/v0\/.*\/Spam%20Repos/

  describe '.call' do
    before do
      FactoryBot.create(:user)
    end

    context 'the repository does not exist' do
      let(:url) { 'https://www.example.com/owner/repo' }

      it 'does not write to airtable', :vcr do
        ReportAirtableUpdaterService.new(url).report
        expect(a_request(:post, AIRTABLE_URI_REGEX)).to_not have_been_made
      end
    end

    context 'the repository does exist' do
      let(:url) { 'https://github.com/raise-dev/hacktoberfest-test' }

      context 'the repository is already known to be spam' do
        before do
          allow(SpamRepositoryService)
            .to receive(:call).with(any_args).and_return(true)
          ReportAirtableUpdaterService.new(url).report
        end

        it 'does not write to airtable', :vcr do
          expect(a_request(:post, AIRTABLE_URI_REGEX)).to_not have_been_made
        end
      end

      context 'the repository is not already marked as spam' do
        before do
          allow(SpamRepositoryService)
            .to receive(:call).with(any_args).and_return(false)
          ReportAirtableUpdaterService.new(url).report
        end

        it 'writes to airtable' , :vcr do
          expect(a_request(:post, AIRTABLE_URI_REGEX)).to have_been_made
        end
      end
    end
  end
end
