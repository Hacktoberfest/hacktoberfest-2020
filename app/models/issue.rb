# frozen_string_literal: true

class Issue < ApplicationRecord
  belongs_to :repository

  validates :gh_database_id, presence: true, uniqueness: true
  validates :number, presence: true, uniqueness: { scope: :repository_id }
  validates :title, presence: true
  validates :url, presence: true

  class << self
    def open_issues_with_unique_permitted_repositories
      random_unique_repo_issues = <<~SQL
        (
          SELECT DISTINCT ON ("repositories"."id") "issues".*
          FROM issues
          INNER JOIN "repositories" ON "repositories"."id" = issues.repository_id
          WHERE issues.open = TRUE AND "repositories"."banned" = FALSE
          ORDER BY "repositories"."id", RANDOM()
        ) random_unique_repo_issues
      SQL

      select('*').from(Arel.sql(random_unique_repo_issues))
    end

    def open_issues_for_language_with_unique_permitted_repositories(language_id)
      random_unique_repo_issues = <<~SQL
        (
          SELECT DISTINCT ON ("repositories"."id") "issues".*
          FROM issues
          INNER JOIN "repositories" ON "repositories"."id" = issues.repository_id
          WHERE issues.open = TRUE AND "repositories"."banned" = FALSE
            AND "repositories"."language_id" = ?
          ORDER BY "repositories"."id", RANDOM()
        ) random_unique_repo_issues
      SQL

      select('*').from(sanitize_sql([random_unique_repo_issues, language_id]))
    end

    def open_issues_with_permitted_repositories
      joins(:repository)
        .where(
          open: true,
          repositories: { banned: false }
        )
    end
  end
end
