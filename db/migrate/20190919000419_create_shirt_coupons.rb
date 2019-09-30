class CreateShirtCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :shirt_coupons do |t|
      t.string :code, null: false
      t.integer :user_id
    end
  end
end
