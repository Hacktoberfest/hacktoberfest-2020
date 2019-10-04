# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CouponService do
  let(:user) { FactoryBot.create(:user, :completed) }
  let(:coupon_service) { CouponService.new(user) }

  describe '#assign_coupon' do
    context 'there are only shirt coupons available' do
      before do
        FactoryBot.create(:shirt_coupon)
        coupon_service.assign_coupon
      end

      it 'assigns the user a shirt coupon' do
        expect(user.shirt_coupon).to be_a(ShirtCoupon)
      end

      it 'does not assign a sticker coupon' do
        expect(user.sticker_coupon).to eq(nil)
      end
    end

    context 'there are only sticker coupons available' do
      before do
        FactoryBot.create(:sticker_coupon)
        coupon_service.assign_coupon
      end

      it 'assigns the user a sticker coupon' do
        expect(user.sticker_coupon).to be_a(StickerCoupon)
      end

      it 'does not assign a shirt coupon' do
        expect(user.shirt_coupon).to eq(nil)
      end
    end

    context 'there are both shirt and sticker coupons available' do
      before do
        FactoryBot.create(:shirt_coupon)
        FactoryBot.create(:sticker_coupon)
        coupon_service.assign_coupon
      end

      it 'assigns the user a shirt coupon' do
        expect(user.shirt_coupon).to be_a(ShirtCoupon)
      end

      it 'does not assign a sticker coupon' do
        expect(user.sticker_coupon).to eq(nil)
      end
    end

    context 'there are neither shirt nor sticker coupons available' do
      before do
        coupon_service.assign_coupon
      end

      it 'does not assign a shirt coupon' do
        expect(user.shirt_coupon).to eq(nil)
      end

      it 'does not assign a sticker coupon' do
        expect(user.sticker_coupon).to eq(nil)
      end
    end
  end
end
