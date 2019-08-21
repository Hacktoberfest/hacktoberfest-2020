class AddConfirmationAndMarketingEmailsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :terms_acceptance, :boolean, default: false
    add_column :users, :marketing_emails, :boolean, default: false
  end
end
