# frozen_string_literal: true

class AddLastErrorToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :last_error, :string
  end
end
