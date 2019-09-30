# frozen_string_literal: true

class ShirtCoupon < ApplicationRecord
  belongs_to :user, optional: true
  validates_associated :user
  validates :code, presence: true

  def self.first_available
    where(user_id: nil).first
  end
end
