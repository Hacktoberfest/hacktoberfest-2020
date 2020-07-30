# frozen_string_literal: true

class AddStateToPullRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :pull_requests, :state, :string
  end
end
