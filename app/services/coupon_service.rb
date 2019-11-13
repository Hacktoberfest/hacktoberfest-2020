# frozen_string_literal: true

class CouponService
  def initialize(user)
    @user = user
  end

  def assign_coupon
    if shirt_coupon.present?
      @user.association(:shirt_coupon).replace(shirt_coupon, false)
    elsif sticker_coupon.present?
      @user.association(:sticker_coupon).replace(sticker_coupon, false)
    end
  end

  def gift_coupon
    if sticker_coupon.present?
      @user.association(:sticker_coupon).replace(sticker_coupon, false)
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
