# frozen_string_literal: true

require 'rails_helper'

describe ReportAirtableUpdaterService do
  AIRTABLE_URI_REGEX = %r{https://api\.airtable\.com/v0/.*/Spam%20Repos}.freeze

  describe '.call' do
    before do
      allow(GithubTokenService).to receive(:random)
        .and_return(ENV.fetch('TEST_USER_GITHUB_TOKEN'))
    end

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

      # This will now write to Airtable with an updated report count
      # Testing this requires faking an existing Airtable record instance etc.
      # context 'the repository is already known to be spam' do
      #   before do
      #     existent_repo_id = 211_178_535
      #     # FIXME: This needs to return a fake Airtable record
      #     allow(ReportAirtableUpdaterService)
      #       .to receive(:spammy_repo_report)
      #       .with(existent_repo_id).and_return({})
      #     ReportAirtableUpdaterService.call(report)
      #   end
      #
      #   it 'does not write to airtable', :vcr do
      #     expect(a_request(:post, AIRTABLE_URI_REGEX)).to_not have_been_made
      #   end
      # end

      context 'the repository is not already marked as spam' do
        before do
          new_repo_id = 211_178_535
          allow(ReportAirtableUpdaterService)
            .to receive(:spammy_repo_report)
            .with(new_repo_id).and_return(nil)
          ReportAirtableUpdaterService.call(report)
        end

        it 'writes to airtable', vcr: { record: :new_episodes } do
          expect(a_request(:post, AIRTABLE_URI_REGEX)).to have_been_made
        end
      end
    end
  end
end
