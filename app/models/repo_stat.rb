# frozen_string_literal: true

class RepoStat < ApplicationRecord
  validates :data, presence: true
  validates :repo_id, presence: true, uniqueness: true
end
