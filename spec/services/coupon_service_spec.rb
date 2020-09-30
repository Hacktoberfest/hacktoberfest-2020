# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CouponService do
  before do
    allow(UserPullRequestSegmentUpdaterService)
      .to receive(:call).and_return(true)
  end

  describe '#assign_coupon' do
    context 'with a completed user' do
      let(:user) { FactoryBot.create(:user, :completed) }
      let(:coupon_service) { CouponService.new(user) }

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

    context 'with an incompleted user' do
      before { travel_to Time.zone.parse(ENV['END_DATE']) + 1.day }
      let(:user) { FactoryBot.create(:user, :incompleted) }
      let(:coupon_service) { CouponService.new(user) }

      context 'there are only shirt coupons available' do
        before do
          FactoryBot.create(:shirt_coupon)
          coupon_service.assign_coupon
        end

        # TODO: Add this test to allow gifting of extra shirt
        # coupons in future Hacktoberfest events.
        xit 'assigns the user a shirt coupon' do
          expect(user.shirt_coupon).to be_a(ShirtCoupon)
        end

        it 'does not assign a sticker coupon' do
          expect(user.sticker_coupon).to eq(nil)
        end
      end

      context 'there are both shirt and sticker coupons available' do
        before do
          FactoryBot.create(:shirt_coupon)
          FactoryBot.create(:sticker_coupon)
          coupon_service.assign_coupon
        end

        # TODO: Add this test to allow gifting of extra shirt
        # coupons in future Hacktoberfest events.
        xit 'assigns the user a shirt coupon' do
          expect(user.shirt_coupon).to be_a(ShirtCoupon)
        end

        # TODO: Add this test to allow gifting of extra shirt
        # coupons in future Hacktoberfest events.
        xit 'does not assign a sticker coupon' do
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

      context 'there are no coupons available' do
        before do
          coupon_service.assign_coupon
        end

        it 'does not assign a shirt coupon' do
          expect(user.shirt_coupon).to eq(nil)
        end

        it 'does not assign the user a sticker coupon' do
          expect(user.sticker_coupon).to eq(nil)
        end
      end

      after { travel_back }
    end
  end
end
