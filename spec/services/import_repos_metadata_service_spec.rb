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

    context 'The user has been deleted from Github' do
      before do
        allow_any_instance_of(GithubPullRequestService)
          .to receive(:pull_requests)
          .and_raise(GithubPullRequestService::UserDeletedError.new)
      end

      it 'updates the correct UserStat' do
        user_stat = UserStat.create(user_id: user.id, data: user)

        ImportReposMetadataService.call(user)

        user_stat.reload
        expect(user_stat.deleted).to eq(true)
      end
    end
  end
end
