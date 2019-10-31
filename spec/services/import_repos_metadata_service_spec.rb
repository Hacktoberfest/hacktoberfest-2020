# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImportReposMetadataService do
  describe '.call' do
    let(:user) { FactoryBot.create(:user) }
    context 'The user has no PRs' do
      before do
        allow_any_instance_of(PullRequestService)
          .to receive(:all).and_return([])
      end

      it 'enqueues no ImportRepoMetadataJobs' do
        ImportReposMetadataService.call(user)

        expect(ImportRepoMetadataJob).to_not receive(:perform_async)
      end
    end
  end
end
