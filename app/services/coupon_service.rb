# frozen_string_literal: true

class CouponService
  def initialize(user)
    @user = user
  end

  def assign_coupon
    if coupon = shirt_coupon
      @user.association(:shirt_coupon).replace(coupon, false)
    elsif coupon = sticker_coupon
      @user.association(:sticker_coupon).replace(coupon, false)
    end
    UserCouponSegmentService.call(@user)
  end

  private

  def shirt_coupon
    ShirtCoupon.first_available
  end

  def sticker_coupon
    StickerCoupon.first_available
  end
end
