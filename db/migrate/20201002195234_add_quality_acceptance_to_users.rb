# frozen_string_literal: true

class AddQualityAcceptanceToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :quality_acceptance, :boolean, default: false
  end
end
