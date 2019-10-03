# frozen_string_literal: true

# This class relays the appropiate data to Segment for specific
# user state transitions.
module UserCouponSegmentService
  module_function

  def call(user)
    if user.shirt_coupon.present?
      shirt(user)
    elsif user.sticker_coupon.present?
      sticker(user)
    end
  end

  def sticker(user)
    segment(user).identify(sticker_coupon: user.sticker_coupon)
    segment(user).track('sticker_coupon')
  end

  def shirt(user)
    segment(user).identify(shirt_coupon: user.shirt_coupon)
    segment(user).track('shirt_coupon')
  end

  def segment(user)
    SegmentService.new(user)
  end
end
