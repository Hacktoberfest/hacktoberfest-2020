# frozen_string_literal: true

class AddIndexToShirtCoupons < ActiveRecord::Migration[5.2]
  def change
    add_index :shirt_coupons, :user_id, unique: true
  end
end
