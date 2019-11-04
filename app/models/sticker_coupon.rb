# frozen_string_literal: true

class StickerCoupon < ApplicationRecord
  belongs_to :user, optional: true

  validates :code, presence: true
  validates_associated :user

  def self.first_available
    where(user_id: nil).order(Arel.sql('RANDOM()')).sample
  end
end
