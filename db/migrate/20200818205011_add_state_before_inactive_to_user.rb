class AddStateBeforeInactiveToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :state_before_inactive, :string
  end
end
