# frozen_string_literal: true

namespace :gift do
  desc 'gift remaining stickers to incompleted users'
  task stickers: :environment do
    shirt_coupon_count = ShirtCoupon.where(user_id: nil).count
    sticker_coupon_count = StickerCoupon.where(user_id: nil).count

    incompleted_user_count = User.where(state: 'incompleted').count

    message = "There are #{shirt_coupon_count} shirts and
      #{sticker_coupon_count} stickers remaining.
      There are #{incompleted_user_count} users who are incompleted
      and eligible for a gifted_shirt or gifted_sticker.

      Do you want to gift the remaining coupons to incompleted users? (y/n)"

    Rails.logger.info message

    input = STDIN.gets.strip

    if input == 'y'
      Rails.logger.info 'Gifting coupons...'
      GiftService.call
    else
      Rails.logger.info 'Terminating.'
    end
  end
end
