# frozen_string_literal: true

class AddUserStatsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :user_stats do |t|
      t.jsonb :data
      t.integer :user_id

      t.timestamps
    end
  end
end
