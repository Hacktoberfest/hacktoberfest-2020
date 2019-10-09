# frozen_string_literal: true

# rubocop:disable Rails/CreateTableWithTimestamps
class CreateStickerCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :sticker_coupons do |t|
      t.string :code, null: false
      t.integer :user_id
    end
  end
end
# rubocop:enable Rails/CreateTableWithTimestamps
