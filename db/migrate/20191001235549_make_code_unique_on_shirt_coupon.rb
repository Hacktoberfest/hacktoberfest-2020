# frozen_string_literal: true

class MakeCodeUniqueOnShirtCoupon < ActiveRecord::Migration[5.2]
  def change
    add_index :shirt_coupons, :code, unique: true
  end
end
