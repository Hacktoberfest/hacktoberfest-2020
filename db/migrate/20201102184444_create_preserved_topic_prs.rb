# frozen_string_literal: true

class CreatePreservedTopicPrs < ActiveRecord::Migration[5.2]
  def change
    create_table :preserved_topic_prs do |t|
      t.string :pr_id, unique: true
      t.timestamps
    end
  end
end
