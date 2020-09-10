# frozen_string_literal: true

class ChangeUserMarketingEmailOptions < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :marketing_emails, :digitalocean_marketing_emails
    add_column :users, :intel_marketing_emails, :boolean, :default => false
    add_column :users, :dev_marketing_emails, :boolean, :default => false
  end
end
