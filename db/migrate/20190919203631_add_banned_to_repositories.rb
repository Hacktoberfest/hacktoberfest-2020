class AddBannedToRepositories < ActiveRecord::Migration[5.2]
  def change
    add_column :repositories, :banned?, :boolean
  end
end
