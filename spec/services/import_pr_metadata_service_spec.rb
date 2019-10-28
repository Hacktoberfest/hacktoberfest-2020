# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImportPRMetadataService do
  describe '.call' do
    let(:user) { FactoryBot.create(:user) }
    context 'The user has PRs' do
      before do
        prs = pull_request_data(PR_DATA[:mature_array]).map do |pr|
          PullRequest.new(pr)
        end

        allow(user).to receive(:pull_requests).and_return(prs)
      end
      context 'the PRs are absent in the pr stats table' do
        it 'creates a UserStat' do
          ImportPRMetadataService.call(user)

          expect(PRStat.count).to eq(4)
        end
      end
      context 'the PRs are present in the pr stats table' do
        it 'does not create another PRStat' do
          prs = pull_request_data(PR_DATA[:mature_array]).map do |pr|
            pull_request = PullRequest.new(pr)
            PRStat.create(pr_id: pull_request.id, data: pull_request)
          end

          ImportPRMetadataService.call(user)

          expect(PRStat.count).to eq(4)
        end
      end
    end

    context 'The user has no PRs' do
    end
  end
end
