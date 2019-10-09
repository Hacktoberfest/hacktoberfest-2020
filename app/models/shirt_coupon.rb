# frozen_string_literal: true

class ShirtCoupon < ApplicationRecord
  belongs_to :user, optional: true

  validates :code, presence: true
  validates_associated :user

  def self.first_available
    find_by(user_id: nil)
  end
end
