# frozen_string_literal: true

class CouponService
  def initialize(user)
    @user = user
  end

  def assign_coupon
    if coupon = shirt_coupon
      @user.shirt_coupon = coupon
    elsif coupon = sticker_coupon
      @user.sticker_coupon = coupon
    end
  end

  private

  def shirt_coupon
    ShirtCoupon.first_available
  end

  def sticker_coupon
    StickerCoupon.first_available
  end
end
