# frozen_string_literal: true

class StickerCoupon < ApplicationRecord
  belongs_to :user, optional: true

  validates :code, presence: true, uniqueness: true
  validates_associated :user

  def self.first_available
    where(user_id: nil).first
  end
end
