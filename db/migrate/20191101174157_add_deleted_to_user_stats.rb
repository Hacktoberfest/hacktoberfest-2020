# frozen_string_literal: true

class AddDeletedToUserStats < ActiveRecord::Migration[5.2]
  def change
    change_table :user_stats do |t|
      t.boolean :deleted
    end
  end
end
