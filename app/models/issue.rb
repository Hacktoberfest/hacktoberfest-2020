# frozen_string_literal: true

class Issue < ApplicationRecord
  belongs_to :repository

  validates :gh_database_id, presence: true, uniqueness: true
  validates :number, presence: true, uniqueness: { scope: :repository_id }
  validates :title, presence: true
  validates :url, presence: true

  def self.random
    order(Arel.sql('RANDOM()'))
  end

  def self.random_order_weighted_by_quality
    order(Arel.sql('RANDOM()*quality DESC'))
  end

  def self.open_issues_with_unique_permitted_repositories
    Issue
      .select('DISTINCT ON (temporary_random_valid_issues.repository_id)
               temporary_random_valid_issues.*')
      .from(open_issues_with_permitted_repositories.random,
            :temporary_random_valid_issues)
  end

  def self.open_issues_with_permitted_repositories
    joins(:repository)
      .where(
        open: true,
        repositories: { banned: false }
      )
  end
end
