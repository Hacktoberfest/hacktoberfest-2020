# frozen_string_literal: true


class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :gh_id
      t.integer :gh_token

      t.timestamps
    end
  end
end
