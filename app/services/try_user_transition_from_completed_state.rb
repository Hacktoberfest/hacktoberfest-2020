# frozen_string_literal: true

module TryUserTransitionFromCompletedService
  def self.call(user)
    return unless user.state == 'won_shirt' || user.state == 'won_sticker'

    coupon_service = CouponService.new(user)
    coupon_service.assign_coupon
    if user.shirt_coupon
      user.won_shirt
    elsif user.sticker_coupon
      user.won_sticker
    else
      user
  end
end
