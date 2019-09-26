# frozen_string_literal: true

class ShirtCoupon < ApplicationRecord
  belongs_to :user, optional: true
  validates_associated :user
  validates :code, presence: true

  def first_available
    ShirtCoupon.where(user_id: nil)
  end
end
