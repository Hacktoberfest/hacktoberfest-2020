# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CouponsFromCSVService do
  describe '.call' do
    context 'valid CSV path' do
      let!(:path) { Rails.root.join('spec','fixtures','dummy-shirt.csv') }

      context 'importing shirt coupons' do
        before do
          CouponsFromCSVService.call(path, ShirtCoupon)
        end

        context 'the CSV contains some duplicates' do
          it 'only creates coupons with unique codes' do
            expect(ShirtCoupon.count).to eq(6)
          end

          it 'does not create any sticker coupons' do
            expect(StickerCoupon.count).to eq(0)
          end
        end
      end

      context 'importing sticker coupons' do
        before do
          CouponsFromCSVService.call(path, StickerCoupon)
        end

        context 'the CSV contains some duplicates' do
          it 'only creates coupons with unique codes' do
            expect(StickerCoupon.count).to eq(6)
          end

          it 'does not create any shirt coupons' do
            expect(ShirtCoupon.count).to eq(0)
          end
        end
      end
    end

    context 'invalid CSV path' do
      let!(:path) { Rails.root.join('spec','fixtures','invalid.csv') }

      it 'raises an invalid path error' do
        expect { CouponsFromCSVService.call(path, StickerCoupon) }.to raise_error(CouponsFromCSVService::InvalidPath)
      end
    end
  end
end
