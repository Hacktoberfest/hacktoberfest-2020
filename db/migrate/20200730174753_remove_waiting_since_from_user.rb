# frozen_string_literal: true

class RemoveWaitingSinceFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :waiting_since, :datetime
  end
end
