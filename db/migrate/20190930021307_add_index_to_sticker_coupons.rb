class AddIndexToStickerCoupons < ActiveRecord::Migration[5.2]
  def change
    add_index :sticker_coupons, :user_id, unique: true
  end
end
