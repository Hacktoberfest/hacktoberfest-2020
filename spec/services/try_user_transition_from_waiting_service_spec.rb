# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TryUserTransitionFromWaitingService do
  describe '.call' do
    let(:user) { FactoryBot.create(:user, :waiting) }

    context 'The user has enough mature PRs to transition' do
      before do
        allow(user).to receive(:mature_pull_requests_count).and_return(4)
        TryUserTransitionFromWaitingService.call(user)
      end

      it 'transisitons the user to the completed state' do
        expect(user.state).to eq('completed')
      end
    end

    context 'The user has insufficient mature PRs to transition' do
      before do
        allow(user).to receive(:mature_pull_requests_count).and_return(3)
        TryUserTransitionFromWaitingService.call(user)
      end

      it 'does not transition the user to the completed state' do
        expect(user.state).to eq('waiting')
      end
    end

    context 'The user has dropped below 4 eligible prs' do
      before do
        allow(user).to receive(:mature_pull_requests_count).and_return(3)
        allow(user).to receive(:eligible_pull_requests_count).and_return(3)

        TryUserTransitionFromWaitingService.call(user)
      end

      it 'transitions the user to the registered state' do
        expect(user.state).to eq('registered')
      end
    end
  end
end
