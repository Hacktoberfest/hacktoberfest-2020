# frozen_string_literal: true

class AddRecieptToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :receipt, :jsonb
  end
end
