# frozen_string_literal: true

require 'rails_helper'

describe ReportAirtableUpdaterService do
  AIRTABLE_URI_REGEX = /https:\/\/api\.airtable\.com\/v0\/.*\/Spam%20Repos/

  describe '.call' do
    # Needed to create an access token
    before { FactoryBot.create(:user) }

    context 'the repository does not exist' do
      let(:report) { Report.new(url: 'https://www.example.com/owner/repo') }

      it 'does not write to airtable', :vcr do
        ReportAirtableUpdaterService.call(report)
        expect(a_request(:post, AIRTABLE_URI_REGEX)).to_not have_been_made
      end
    end

    context 'the repository does exist' do
      let(:report) do
        Report.new(url: 'https://github.com/raise-dev/hacktoberfest-test')
      end

      context 'the repository is already known to be spam' do
        before do
          allow(SpamRepositoryService)
            .to receive(:call).with(any_args).and_return(true)
          ReportAirtableUpdaterService.call(report)
        end

        it 'does not write to airtable', :vcr do
          expect(a_request(:post, AIRTABLE_URI_REGEX)).to_not have_been_made
        end
      end

      context 'the repository is not already marked as spam' do
        before do
          allow(SpamRepositoryService)
            .to receive(:call).with(any_args).and_return(false)
          ReportAirtableUpdaterService.call(report)
        end

        it 'writes to airtable' , :vcr do
          expect(a_request(:post, AIRTABLE_URI_REGEX)).to have_been_made
        end
      end
    end
  end
end
