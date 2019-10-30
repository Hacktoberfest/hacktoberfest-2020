# frozen_string_literal: true

class CreateRepoStats < ActiveRecord::Migration[5.2]
  def change
    create_table :repo_stats do |t|
      t.jsonb :data, null: false
      t.string :repo_id, unique: true

      t.timestamps
    end
  end
end
