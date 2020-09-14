# frozen_string_literal: true

class AddCategoryToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :category, :string, default: 'participant'
  end
end
