# frozen_string_literal: true

class StickerCoupon < ApplicationRecord
  belongs_to :user, optional: true
  validates_associated :user
  validates :code, presence: true

  def first_available
    StickerCoupon.where(user_id: nil).first
  end
end
