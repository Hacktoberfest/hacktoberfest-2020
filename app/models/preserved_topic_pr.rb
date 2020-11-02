# frozen_string_literal: true

class PreservedTopicPR < ApplicationRecord
  # Maintainers are removing topics from their repos before PRs can mature
  # This holds all waiting PRs as of Oct 31. so they can bypass the topic check
  validates :pr_id, presence: true, uniqueness: true
end
