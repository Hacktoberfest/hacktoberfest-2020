# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'TryUserTransitionFromRegisteredService' do
  describe '.call' do
    let(:user) { FactoryBot.create(:user) }

    before do
      allow(UserStateTransitionSegmentService).to receive(:call)
      allow(UserPullRequestSegmentUpdaterService).to receive(:call)
    end

    context 'The user has enough PRs to transition' do
      before do
        pr_stub_helper(user, PR_DATA[:immature_array])
        TryUserTransitionFromRegisteredService.call(user)
      end

      it 'transisitons the user to the waiting state' do
        expect(user.state).to eq('waiting')
      end
    end

    context 'The user has insufficient PRs to transition' do
      before do
        pr_stub_helper(user, PR_DATA[:immature_array][0...3])
        TryUserTransitionFromRegisteredService.call(user)
      end

      it 'does not transition the user to the waiting state' do
        expect(user.state).to eq('registered')
      end
    end

    context 'The user has insufficient PRs and Hacktoberfest has ended' do
      before do
        travel_to Time.zone.parse(ENV['END_DATE']) + 1.day
        pr_stub_helper(user, PR_DATA[:mature_array][0...3])
        TryUserTransitionFromRegisteredService.call(user)
      end

      it 'transitions the user to the incompleted state' do
        expect(user.state).to eq('incompleted')
      end

      after { travel_back }
    end
  end
end
