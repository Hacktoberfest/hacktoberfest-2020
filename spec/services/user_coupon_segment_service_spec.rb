# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserCouponSegmentService do
  describe '.call' do
    context 'the user won a shirt' do
      let(:user) { FactoryBot.create(:user, :won_shirt) }

      it 'calls SegmentService#identify with proper arguments' do
        expect_any_instance_of(SegmentService).to receive(:identify).with(
          shirt_coupon: user.shirt_coupon
        )
        allow_any_instance_of(SegmentService).to receive(:track).with(
          'shirt_coupon'
        )
        UserCouponSegmentService.call(user)
      end

      it 'calls SegmentService#track with proper arguments' do
        allow_any_instance_of(SegmentService).to receive(:identify).with(
          shirt_coupon: user.shirt_coupon
        )
        expect_any_instance_of(SegmentService).to receive(:track).with(
          'shirt_coupon'
        )
        UserCouponSegmentService.call(user)
      end
    end

    context 'the user won a sticker' do
      let(:user) { FactoryBot.create(:user, :won_sticker) }

      it 'calls SegmentService#identify with proper arguments' do
        expect_any_instance_of(SegmentService).to receive(:identify).with(
          sticker_coupon: user.sticker_coupon
        )
        allow_any_instance_of(SegmentService).to receive(:track).with(
          'sticker_coupon'
        )
        UserCouponSegmentService.call(user)
      end

      it 'calls SegmentService#track with proper arguments' do
        allow_any_instance_of(SegmentService).to receive(:identify).with(
          sticker_coupon: user.sticker_coupon
        )
        expect_any_instance_of(SegmentService).to receive(:track).with(
          'sticker_coupon'
        )
        UserCouponSegmentService.call(user)
      end
    end

    context 'the user won nothing' do
      let(:user) { FactoryBot.create(:user) }

      it 'does not call SegmentService#identify' do
        expect_any_instance_of(SegmentService).to_not receive(:identify)
        UserCouponSegmentService.call(user)
      end

      it 'calls SegmentService#track with proper arguments' do
        expect_any_instance_of(SegmentService).to_not receive(:track)
        UserCouponSegmentService.call(user)
      end
    end
  end
end
