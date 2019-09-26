# frozen_string_literal: true

class CouponService
  def initialize(user)
    @user = user
  end

  def assign_coupon
    assign_shirt_coupon
    assign_sticker_coupon
  end

  def assign_shirt_coupon
    coupon = ShirtCoupon.first_available
    coupon.user = @user
  end

  def assign_sticker_coupon
    coupon = StickerCoupon.first_available
    coupon.user = @user
  end

end
