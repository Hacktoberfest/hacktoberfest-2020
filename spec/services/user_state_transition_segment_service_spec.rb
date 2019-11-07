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
        allow_any_instance_of(SegmentService).to receive(:track).with(
          'register'
        )
        UserStateTransitionSegmentService.call(user, transition)
      end

      it 'calls SegmentService#track with proper arguments' do
        allow_any_instance_of(SegmentService).to receive(:identify).with(
          email: user.email,
          marketing_emails: user.marketing_emails,
          state: 'register'
        )
        expect_any_instance_of(SegmentService).to receive(:track).with(
          'register'
        )
        UserStateTransitionSegmentService.call(user, transition)
      end
    end

    context 'the transition event is complete and the user is waiting' do
      let(:user) { FactoryBot.create(:user, :waiting) }

      before do
        allow(transition).to receive(:event).and_return(:complete)
      end

      it 'calls SegmentService#identify with proper arguments' do
        allow_any_instance_of(SegmentService).to receive(:track).with(
          'user_completed'
        )
        expect_any_instance_of(SegmentService).to receive(:identify).with(
          state: 'completed'
        )
        UserStateTransitionSegmentService.call(user, transition)
      end

      it 'calls SegmentService#track with proper arguments' do
        allow_any_instance_of(SegmentService).to receive(:identify).with(
          state: 'completed'
        )
        expect_any_instance_of(SegmentService).to receive(:track).with(
          'user_completed'
        )
        UserStateTransitionSegmentService.call(user, transition)
      end
    end

    context 'the event is retry_complete and the user is incompleted' do
      let(:user) { FactoryBot.create(:user, :incompleted) }

      before do
        allow(transition).to receive(:event).and_return(:retry_complete)
      end

      it 'calls SegmentService#identify with proper arguments' do
        allow_any_instance_of(SegmentService).to receive(:track).with(
          'user_completed'
        )
        expect_any_instance_of(SegmentService).to receive(:identify).with(
          state: 'completed'
        )
        UserStateTransitionSegmentService.call(user, transition)
      end

      it 'calls SegmentService#track with proper arguments' do
        allow_any_instance_of(SegmentService).to receive(:identify).with(
          state: 'completed'
        )
        expect_any_instance_of(SegmentService).to receive(:track).with(
          'user_completed'
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
        allow_any_instance_of(SegmentService).to receive(:track).with(
          'user_ineligible'
        )
        expect_any_instance_of(SegmentService).to receive(:identify).with(
          state: 'ineligible'
        )
        UserStateTransitionSegmentService.call(user, transition)
      end

      it 'calls SegmentService#track with proper arguments' do
        allow_any_instance_of(SegmentService).to receive(:identify).with(
          state: 'ineligible'
        )
        expect_any_instance_of(SegmentService).to receive(:track).with(
          'user_ineligible'
        )
        UserStateTransitionSegmentService.call(user, transition)
      end
    end

    context 'the transition event is won and the user is completed' do
      let(:user) { FactoryBot.create(:user, :completed) }

      before do
        allow(transition).to receive(:event).and_return(:won)
      end

      context 'the user won a shirt' do
        let(:coupon) { FactoryBot.create(:shirt_coupon) }

        before do
          allow(transition).to receive(:to).and_return('won_shirt')
        end

        it 'calls SegmentService#identify with proper arguments' do
          expect_any_instance_of(SegmentService).to receive(:identify).with(
            state: 'won_shirt'
          )
          expect_any_instance_of(SegmentService).to receive(:track).with(
            'user_won_shirt'
          )
          UserStateTransitionSegmentService.call(user, transition)
        end

        it 'calls SegmentService#track with proper arguments' do
          expect_any_instance_of(SegmentService).to receive(:identify).with(
            state: 'won_shirt'
          )
          expect_any_instance_of(SegmentService).to receive(:track).with(
            'user_won_shirt'
          )
          UserStateTransitionSegmentService.call(user, transition)
        end
      end

      context 'the user won a sticker' do
        let(:coupon) { FactoryBot.create(:sticker_coupon) }

        before do
          allow(transition).to receive(:to).and_return('won_sticker')
        end

        it 'calls SegmentService#identify with proper arguments' do
          expect_any_instance_of(SegmentService).to receive(:identify).with(
            state: 'won_sticker'
          )
          expect_any_instance_of(SegmentService).to receive(:track).with(
            'user_won_sticker'
          )
          UserStateTransitionSegmentService.call(user, transition)
        end

        it 'calls SegmentService#track with proper arguments' do
          expect_any_instance_of(SegmentService).to receive(:identify).with(
            state: 'won_sticker'
          )
          expect_any_instance_of(SegmentService).to receive(:track).with(
            'user_won_sticker'
          )
          UserStateTransitionSegmentService.call(user, transition)
        end
      end
    end
  end
end
