# frozen_string_literal: true

class AddDisqualifyAcceptanceToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :disqualify_acceptance, :boolean, default: false
  end
end
