# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GiftService do
  before do
    allow(UserPullRequestSegmentUpdaterService)
      .to receive(:call).and_return(true)
    allow(UserStateTransitionSegmentService)
      .to receive(:call).and_return(true)
  end

  describe '.call' do
    context 'Users in the incompleted state' do
      before { travel_to Time.zone.parse(ENV['END_DATE']) + 1.day }

      let(:user_with_early_receipt_2prs) do
        FactoryBot.create(:user, :incompleted)
      end
      let(:user_with_early_receipt_3prs) do
        FactoryBot.create(:user, :incompleted)
      end
      let(:user_with_late_receipt_2prs) do
        FactoryBot.create(:user, :incompleted)
      end
      let(:user_with_late_receipt_3prs) do
        FactoryBot.create(:user, :incompleted)
      end

      before do
        user_with_early_receipt_2prs
          .update(receipt: UserReceiptHelper.receipt[:early_receipt_2_prs])
        user_with_early_receipt_3prs
          .update(receipt: UserReceiptHelper.receipt[:early_receipt_3_prs])
        user_with_late_receipt_2prs
          .update(receipt: UserReceiptHelper.receipt[:late_receipt_2_prs])
        user_with_late_receipt_3prs
          .update(receipt: UserReceiptHelper.receipt[:late_receipt_3_prs])
      end

      context 'there is 1 sticker coupon' do
        before do
          FactoryBot.create(:sticker_coupon)
          GiftService.call
        end

        it 'assigns the coupon to earliest user with most PRS' do
          user_with_early_receipt_3prs.reload
          expect(user_with_early_receipt_3prs.sticker_coupon)
            .to be_a(StickerCoupon)
        end
      end

      context 'there are 2 sticker coupons' do
        before do
          FactoryBot.create(:sticker_coupon)
          FactoryBot.create(:sticker_coupon)
          GiftService.call
        end

        it 'assigns a coupon to early user with 3 PRS' do
          user_with_early_receipt_3prs.reload
          expect(user_with_early_receipt_3prs.sticker_coupon)
            .to be_a(StickerCoupon)
        end

        it 'assigns a coupon to late user with 3 PRS' do
          user_with_late_receipt_3prs.reload
          expect(user_with_late_receipt_3prs.sticker_coupon)
            .to be_a(StickerCoupon)
        end
      end

      context 'there are 3 sticker coupons' do
        before do
          FactoryBot.create(:sticker_coupon)
          FactoryBot.create(:sticker_coupon)
          FactoryBot.create(:sticker_coupon)
          GiftService.call
        end

        it 'assigns a coupon to early user with 3 PRS' do
          user_with_early_receipt_3prs.reload
          expect(user_with_early_receipt_3prs.sticker_coupon)
            .to be_a(StickerCoupon)
        end

        it 'assigns a coupon to late user with 3 PRS' do
          user_with_late_receipt_3prs.reload
          expect(user_with_late_receipt_3prs.sticker_coupon)
            .to be_a(StickerCoupon)
        end

        it 'assigns a coupon to early user with 2 PRs' do
          user_with_early_receipt_2prs.reload
          expect(user_with_early_receipt_2prs.sticker_coupon)
            .to be_a(StickerCoupon)
        end
      end

      after { travel_back }
    end
  end
end
