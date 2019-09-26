# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CouponService do
  let(:user) { FactoryBot.create(:user) }
  let(:coupon_service) { CouponService.new(user) }

  describe 'assign_coupon' do
    context 'there are shirt coupons available' do
      it 'only assigns the user a shirt_coupon' do
        expect(user.shirt_coupon).to_not be(nil)
        expect(user.sticker_coupon).to be(nil)
      end
    end

    context 'there are no shirt coupons available' do
      it 'only assigns the user a sticker_coupon' do
        expect(user.sticker_coupon).to_not be(nil)
      end

      it 'does not assign the user a shirt_coupon' do
        expect(user.shirt_coupon).to be(nil)
      end
    end
  end
end
