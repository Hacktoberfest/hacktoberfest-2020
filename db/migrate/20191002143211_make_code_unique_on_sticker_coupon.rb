class MakeCodeUniqueOnStickerCoupon < ActiveRecord::Migration[5.2]
  def change
    add_index :sticker_coupons, :code, unique: true
  end
end
