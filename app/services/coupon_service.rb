# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CouponService do
  let(:user) { FactoryBot.create(:user) }
  let(:coupon_service) { CouponService.new(user) }


  describe 'assign_coupon' do
    context 'there are shirt coupons available' do
      it 'assigns the user a shirt_coupon' do

      end
    end

    context 'there are no shirt coupons available' do
      it 'assigns the user a sticker_coupon' do

      end

      it 'does not assign the user a shirt_coupon' do

      end
    end

    context 'there are no shirt or sticker coupons available' do
      xit 'assigns the user a waiting coupon' do

      end
    end
  end
end
