# frozen_string_literal: true

module ProjectService
  module_function

  def sample(sample_size = 1)
    issues = Issue
             .open_issues_with_unique_permitted_repositories
             .order(quality: :desc)
             .limit(sample_size)
    projects = issues.map { |issue| Project.new(issue) }
    projects
  end
end
