# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TryUserTransitionFromWaitingService do
  describe '.call' do
    let(:user) { FactoryBot.create(:user, :waiting) }

    before do
      allow(UserStateTransitionSegmentService).to receive(:call)
      allow(UserPullRequestSegmentUpdaterService).to receive(:call)

      prs = pull_request_data(PR_DATA[:mature_array]).map do |pr|
        PullRequest.from_github_pull_request(pr)
      end

      allow(user).to receive(:scoring_pull_requests).and_return(prs)
    end

    context 'The user has enough eligible PRs & has been waiting 7+ days' do
      before do
        allow(user).to receive(:eligible_pull_requests_count).and_return(4)
        allow(user).to receive(:waiting_since).and_return(Time.zone.today - 8)
        TryUserTransitionFromWaitingService.call(user)
      end

      it 'transisitons the user to the completed state' do
        expect(user.state).to eq('completed')
      end
    end

    context 'The user has dropped below 4 eligible prs' do
      before do
        allow(user).to receive(:eligible_pull_requests_count).and_return(3)

        TryUserTransitionFromWaitingService.call(user)
      end

      it 'transitions the user to the registered state' do
        expect(user.state).to eq('registered')
      end
    end

    context 'The user needs to continue waiting' do
      before do
        allow(user).to receive(:eligible_pull_requests_count).and_return(4)
        allow(user).to receive(:waiting_since).and_return(Time.zone.today - 3)
        TryUserTransitionFromWaitingService.call(user)
      end

      it 'does not transition the user' do
        expect(user.state).to eq('waiting')
      end
    end
  end
end
