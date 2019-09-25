class AddWaitingSinceToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :waiting_since, :datetime
  end
end
