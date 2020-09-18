# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'TryUserTransitionService' do
  before do
    allow(UserPullRequestSegmentUpdaterService)
      .to receive(:call).and_return(true)
  end

  describe '.call' do
    context 'The user is in the registered state' do
      let(:user) { FactoryBot.create(:user) }

      before do
        pr_stub_helper(user, PR_DATA[:mature_array])
      end

      it 'calls the appropriate service' do
        expect(TryUserTransitionFromRegisteredService)
          .to receive(:call).and_return(true)

        TryUserTransitionService.call(user)
      end
    end

    context 'The user is in the waiting state' do
      let(:user) { FactoryBot.create(:user, :waiting) }

      before do
        pr_stub_helper(user, PR_DATA[:mature_array])
      end

      it 'calls the appropriate service' do
        expect(TryUserTransitionFromWaitingService)
          .to receive(:call).and_return(true)

        TryUserTransitionService.call(user)
      end
    end
  end
end
