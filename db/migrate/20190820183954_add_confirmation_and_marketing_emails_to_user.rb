# frozen_string_literal: true

class AddConfirmationAndMarketingEmailsToUser < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.boolean :terms_acceptance, :marketing_emails, default: false
    end
  end
end
