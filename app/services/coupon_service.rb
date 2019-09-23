# frozen_string_literal: true

class CouponService

  def initialize(user)
    @user = user
  end

  def assign_coupon
    if ShirtCoupon.all.count > 0
      coupon = ShirtCoupon.first
      @user.shirt_coupon = coupon
      coupon.update(user_id: @user.id)
    elsif ShirtCoupon.all.count == 0
      coupon = StickerCoupon.first
      @user.sticker_coupon = coupon
      coupon.update(user_id: @user.id)
    elsif ShirtCoupon.all.count == 0 && StickerCoupon.all.count == 0
      #leave empty or add new column 
    end
  end
end
