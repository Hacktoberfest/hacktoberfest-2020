class AddLockVerisonToStickerCoupon < ActiveRecord::Migration[5.2]
  def change
    add_column :sticker_coupons, :lock_version, :integer, default: 0
  end
end
