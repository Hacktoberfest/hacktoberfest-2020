class AddLockVersionToShirtCoupon < ActiveRecord::Migration[5.2]
  def change
    add_column :shirt_coupons, :lock_version, :integer, default: 0
  end
end
