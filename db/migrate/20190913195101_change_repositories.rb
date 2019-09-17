# frozen_string_literal: true

class ChangeRepositories < ActiveRecord::Migration[5.2]
  def change
    drop_table :repositories do |t|
      t.integer :gh_id

      t.timestamps
    end

    create_table :repositories do |t|
      t.integer :gh_database_id, limit: 8, null: false
      t.string :url, limit: 191, null: false
      t.string :name, null: false
      t.string :full_name, null: false
      t.integer :pull_requests_count, limit: 8, default: 0
      t.integer :language_id, limit: 4
      t.string :description, limit: 191
      t.string :code_of_conduct_url, limit: 191
      t.integer :forks, limit: 8
      t.integer :stars, limit: 8
      t.integer :watchers, limit: 8
      t.boolean :banned, default: false, null: false

      t.timestamps null: false

      t.index :gh_database_id, unique: true
    end
  end
end
