# frozen_string_literal: true

class CouponService
  def initialize(user)
    @user = user
  end

  def assign_coupon
    assign_sticker_coupon unless assign_shirt_coupon
  end

  private

  def shirt_coupon
    ShirtCoupon.first_available
  end

  def sticker_coupon
    StickerCoupon.first_available
  end

  def assign_shirt_coupons
    return if shirt_coupon.blank?

    @user.association(:shirt_coupon).replace(shirt_coupon, false)
  end

  def assign_sticker_coupon
    return if sticker_coupon.blank?

    @user.association(:sticker_coupon).replace(sticker_coupon, false)
  end
end
