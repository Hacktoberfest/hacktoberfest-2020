# frozen_string_literal: true

class ChangeIssues < ActiveRecord::Migration[5.2]
  def change
    drop_table :issues do |t|
      t.integer :gh_id

      t.timestamps
    end

    create_table :issues do |t|
      t.string :title, limit: 191, null: false
      t.integer :number, limit: 8, null: false
      t.integer :gh_database_id, limit: 4, null: false
      t.string :url, limit: 191, null: false
      t.integer :repository_id, limit: 8, null: false
      t.boolean :open, default: true, null: false
      t.integer :timeline_events, limit: 8
      t.integer :participants, limit: 8
      t.float :quality, limit: 24, default: 1.0

      t.timestamps null: false

      t.index :gh_database_id, unique: true
      t.index :repository_id
    end
  end
end
