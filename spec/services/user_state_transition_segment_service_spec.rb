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

    context 'the transition event is won and the user is completed'
      let(:user) { FactoryBot.create(:user, :completed) }

      before do
        allow(transition).to receive(:event).and_return(:won)
      end

      context 'the user won a shirt' do
        let(:coupon) { FactoryBot.create(:shirt_coupon) }

        before do
          user.association(:shirt_coupon).replace(coupon, false)
        end

        it 'calls SegmentService#identify with proper arguments' do
          expect_any_instance_of(SegmentService).to receive(:identify).with(
            state: 'won_shirt',
            shirt_coupon: user.shirt_coupon
          )
          allow_any_instance_of(SegmentService).to receive(:track).with(
            'user_won_shirt'
          )
          UserStateTransitionSegmentService.call(user, transition)
        end

        it 'calls SegmentService#track with proper arguments' do
          allow_any_instance_of(SegmentService).to receive(:identify).with(
            state: 'won_shirt',
            shirt_coupon: user.shirt_coupon
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
          user.association(:sticker_coupon).replace(coupon, false)
        end

        it 'calls SegmentService#identify with proper arguments' do
          expect_any_instance_of(SegmentService).to receive(:identify).with(
            state: 'won_sticker',
            sticker_coupon: user.sticker_coupon
          )
          allow_any_instance_of(SegmentService).to receive(:track).with(
            'user_won_sticker'
          )
          UserStateTransitionSegmentService.call(user, transition)
        end

        it 'calls SegmentService#track with proper arguments' do
          allow_any_instance_of(SegmentService).to receive(:identify).with(
            state: 'won_sticker',
            sticker_coupon: user.sticker_coupon
          )
          expect_any_instance_of(SegmentService).to receive(:track).with(
            'user_won_sticker'
          )
          UserStateTransitionSegmentService.call(user, transition)
        end
      end
    end
end
