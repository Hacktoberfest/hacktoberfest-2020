# frozen_string_literal: true

class CreatePullRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :pull_requests do |t|
      t.integer :gh_id
      t.timestamps
    end
  end
end
