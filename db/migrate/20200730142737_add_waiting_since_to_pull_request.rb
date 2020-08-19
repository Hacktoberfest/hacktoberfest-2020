# frozen_string_literal: true

class AddWaitingSinceToPullRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :pull_requests, :waiting_since, :datetime
  end
end
