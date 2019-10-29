# frozen_string_literal: true

class CreateDailyPrCounts < ActiveRecord::Migration[5.2]
  def change
    create_table :daily_pr_counts do |t|
      t.date :date, null: false, index: { unique: true }
      t.integer :count, default: 0

      t.timestamps
    end
  end
end
