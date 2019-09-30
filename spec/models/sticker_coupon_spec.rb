# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StickerCoupon, type: :model do
  describe '.first_available' do
    context 'coupons available' do
      before do
        FactoryBot.create(described_class.name.underscore.to_sym)
      end

      it 'returns an unused coupon' do
        coupon = described_class.first_available
        expect(coupon.user).to be(nil)
      end
    end

    context 'all coupons consumed' do
      before do
        FactoryBot.create(:user, :won_shirt)
        FactoryBot.create(:user, :won_sticker)
      end

      it 'returns nil' do
        coupon = described_class.first_available
        expect(coupon).to be(nil)
      end
    end
  end
end
