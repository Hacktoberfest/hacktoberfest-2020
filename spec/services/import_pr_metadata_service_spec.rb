# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImportPrMetadataService do
  describe '.call' do
    let(:user) { FactoryBot.create(:user) }

    context 'The user has PRs' do
      before do
        prs = pull_request_data(PR_DATA[:mature_array]).map do |pr|
          PullRequest.new(pr)
        end

        allow_any_instance_of(PullRequestService)
          .to receive(:all).and_return(prs)
      end

      context 'the PRs are absent in the pr stats table' do
        it 'creates a PRStat' do
          ImportPrMetadataService.call(user)

          expect(PRStat.count).to eq(4)
        end
      end

      context 'the PRs are present in the pr stats table' do
        it 'does not create more PRStats' do
          pull_request_data(PR_DATA[:mature_array]).map do |pr|
            pull_request = PullRequest.new(pr)
            PRStat.create(pr_id: pull_request.id, data: pull_request)
          end

          ImportPrMetadataService.call(user)

          expect(PRStat.count).to eq(4)
        end
      end
    end

    context 'The user has no PRs' do
      before do
        allow_any_instance_of(PullRequestService)
          .to receive(:all).and_return([])
      end

      it 'does not create PRStats' do
        ImportPrMetadataService.call(user)

        expect(PRStat.count).to eq(0)
      end
    end
  end
end
