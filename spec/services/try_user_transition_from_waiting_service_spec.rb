# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TryUserTransitionFromWaitingService do
  describe '.call' do
    let(:user) { FactoryBot.create(:user, :waiting) }

    before do
      allow(UserStateTransitionSegmentService).to receive(:call)
      allow(UserPullRequestSegmentUpdaterService).to receive(:call)
    end

    context 'The user has enough eligible PRs & has been waiting 7+ days' do
      before do
        pr_stub_helper(user, PR_DATA[:mature_array])
        TryUserTransitionFromWaitingService.call(user)
      end

      it 'transisitons the user to the completed state' do
        expect(user.state).to eq('completed')
      end
    end

    context 'The user has dropped below 4 waiting prs' do
      before do
        pr_stub_helper(user, PR_DATA[:immature_array][0...3])
        TryUserTransitionFromWaitingService.call(user)
      end

      it 'transitions the user to the registered state' do
        expect(user.state).to eq('registered')
      end
    end

    context 'The user needs to continue waiting' do
      before do
        pr_stub_helper(user, PR_DATA[:mixed_maturity_array])
        TryUserTransitionFromWaitingService.call(user)
      end

      it 'does not transition the user' do
        expect(user.state).to eq('waiting')
      end
    end
  end
end
