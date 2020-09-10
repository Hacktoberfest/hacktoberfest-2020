# frozen_string_literal: true

class ChangeUserMarketingEmailOptions < ActiveRecord::Migration[5.2]
  def change
    change_table :users, bulk: true do |t|
      t.rename :marketing_emails, :digitalocean_marketing_emails
      t.boolean :intel_marketing_emails, :dev_marketing_emails, default: false
    end
  end
end
