# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'TryUserTransitionFromRegisteredService' do
  describe '.call' do
    let(:user) { FactoryBot.create(:user) }

    context 'The user has enough PRs to transition' do
      before do
        allow(user).to receive(:eligible_pull_requests_count).and_return(4)
        TryUserTransitionFromRegisteredService.call(user)
      end

      it 'transisitons the user to the waiting state' do
        expect(user.state).to eq('waiting')
      end
    end

    context 'The user has insufficient PRs to transition' do
      before do
        allow(user).to receive(:eligible_pull_requests_count).and_return(3)
        TryUserTransitionFromRegisteredService.call(user)
      end

      it 'does not transition the user to the waiting state' do
        expect(user.state).to eq('registered')
      end
    end
  end
end
