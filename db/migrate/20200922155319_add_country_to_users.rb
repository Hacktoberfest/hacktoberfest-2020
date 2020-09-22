# frozen_string_literal: true

class AddCountryToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :country, :string
  end
end
