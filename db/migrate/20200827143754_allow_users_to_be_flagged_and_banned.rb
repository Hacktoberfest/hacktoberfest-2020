class AllowUsersToBeFlaggedAndBanned < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_moderator, :boolean, :default => false
    add_column :users, :system_flagged, :boolean, :default => false
    add_column :users, :system_flagged_at, :timestamp, :default => nil
    add_column :users, :moderator_banned, :boolean, :default => false
    add_column :users, :moderator_banned_at, :timestamp, :default => nil
    add_column :users, :moderator_notes, :text, :default => nil
  end
end
