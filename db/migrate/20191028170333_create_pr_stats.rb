# frozen_string_literal: true

class CreatePrStats < ActiveRecord::Migration[5.2]
  def change
    create_table :pr_stats do |t|
      t.jsonb :data, null: false
      t.string :pr_id, unique: true

      t.timestamps
    end
  end
end
