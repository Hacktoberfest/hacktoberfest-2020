# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserStateTransitionSegmentService do
  let(:transition) { double }

  describe '.call' do
    context 'the transition event is register and the user is new' do
      let(:user) { FactoryBot.create(:user, :new) }

      before do
        allow(transition).to receive(:event).and_return(:register)
      end

      it 'calls SegmentService#identify with proper arguments' do
        expect_any_instance_of(SegmentService).to receive(:identify).with(
          email: user.email,
          marketing_emails: user.marketing_emails,
          state: 'register'
        )
        UserStateTransitionSegmentService.call(user, transition)
      end

      it 'calls SegmentService#track with proper arguments' do
        expect_any_instance_of(SegmentService).to receive(:track).with(
          'register'
        )
        UserStateTransitionSegmentService.call(user, transition)
      end
    end

    context 'the transition event is ineligible and the user is waiting' do
      let(:user) { FactoryBot.create(:user, :waiting) }

      before do
        allow(transition).to receive(:event).and_return(:ineligible)
      end

      it 'calls SegmentService#identify with proper arguments' do
        expect_any_instance_of(SegmentService).to receive(:identify).with(
          state: 'ineligible'
        )
        UserStateTransitionSegmentService.call(user, transition)
      end

      it 'calls SegmentService#track with proper arguments' do
        expect_any_instance_of(SegmentService).to receive(:track).with(
          'user_ineligible'
        )
        UserStateTransitionSegmentService.call(user, transition)
      end
    end
  end
end
