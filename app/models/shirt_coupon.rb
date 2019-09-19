# frozen_string_literal: true

class ShirtCoupon < ApplicationRecord
  belongs_to :user, optional: true
  validates_associated :user
  validates :code, presence: true
end
