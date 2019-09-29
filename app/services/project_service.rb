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

  def language_sample(language_id, sample_size = 1)
    language = Language.find(language_id)
    issues = Issue
             .open_issues_with_unique_permitted_repositories
             .includes(repository: :language)
             .order(quality: :desc)
    projects = issues.map { |issue| Project.new(issue) }
    projects.select { |project| project.language == language.name }
            .sample(sample_size)
  end
end
