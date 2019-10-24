class CreateSpamRepositories < ActiveRecord::Migration[5.2]
  def change
    create_table :spam_repositories do |t|
      t.integer :github_id, index: { unique: true }

      t.timestamps
    end
  end
end
