# frozen_string_literal: true

namespace :gift do
  # TODO: Update this rake task to reflect giving users any remaining available shirt coupons when that is implemented in `CouponService`
  desc 'gift remaining stickers to incompleted users'
  task stickers: :environment do
    sticker_coupon_count = StickerCoupon.where(user_id: nil).count

    incompleted_user_count = User.where(state: 'incompleted').count

    message = "There are #{sticker_coupon_count} stickers remaining.
      There are #{incompleted_user_count} users who are incompleted
      and eligible for gift_sticker.

      Do you want to gift the remaining coupons to incompleted users? (y/n)"

    Rails.logger.info message

    input = STDIN.gets.strip

    if input == 'y'
      Rails.logger.info 'Gifting coupons...'
      GiftStickersService.call
    else
      Rails.logger.info 'Terminating.'
    end
  end
end
