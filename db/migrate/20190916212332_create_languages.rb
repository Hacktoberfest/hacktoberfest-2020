# frozen_string_literal: true

class CreateLanguages < ActiveRecord::Migration[5.2]
  def change
    create_table :languages do |t|
      t.string :name, null: false
      t.index :name, unique: true

      t.timestamps null: false
    end
  end
end
