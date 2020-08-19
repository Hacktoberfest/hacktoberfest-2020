# frozen_string_literal: true

class MakeGhIdStringInPullRequest < ActiveRecord::Migration[5.2]
  def change
    change_column :pull_requests, :gh_id, :string
  end
end
