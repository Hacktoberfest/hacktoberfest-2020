# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'TryUserTransitionService' do
  describe '.call' do
    context 'The user is in the registered state' do
      let(:user) { FactoryBot.create(:user) }

      before do
        allow(user).to receive(:eligible_pull_requests_count).and_return(4)
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
        allow(user).to receive(:eligible_pull_requests_count).and_return(4)
        allow(user).to receive(:waiting_since).and_return(Date.today - 8)
      end

      it 'calls the appropriate service' do
        expect(TryUserTransitionFromWaitingService)
          .to receive(:call).and_return(true)

        TryUserTransitionService.call(user)
      end
    end
  end
end
