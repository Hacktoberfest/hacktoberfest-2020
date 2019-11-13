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

  def assign_shirt_coupon
    if @user.completed? && shirt_coupon.present?
      @user.association(:shirt_coupon).replace(shirt_coupon, false)
    end
  end

  def assign_sticker_coupon
    if sticker_coupon.present?
      @user.association(:sticker_coupon).replace(sticker_coupon, false)
    end
  end
end
