# frozen_string_literal: true

class PreservedTopicPR < ApplicationRecord
  # Maintainers are removing topics from their repos before PRs can mature
  # This holds all waiting PRs as of Oct. 31st so they can bypass the topic check
  validates :pr_id, presence: true, uniqueness: true

  def self.has?(pr_id)
    self.find_by(pr_id: pr_id).present?
  end
end
