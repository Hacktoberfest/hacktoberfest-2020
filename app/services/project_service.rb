# frozen_string_literal: true

module ProjectService
  module_function

  def sample(sample_size = 1)
    issues = Issue
             .open_issues_with_unique_permitted_repositories
             .includes(repository: :language)
             .order(quality: :desc)
             .limit(sample_size * 10)
             .sample(sample_size)
    projects = issues.map { |issue| Project.new(issue) }
    projects
  end

  def language_sample(language, sample_size = 1)
    issues = Issue
      .open_issues_for_language_with_unique_permitted_repositories(language.id)
             .includes(repository: :language)
             .order(quality: :desc)
             .limit(sample_size * 10)
             .sample(sample_size)
    projects = issues.map { |issue| Project.new(issue) }
    projects
  end
end
