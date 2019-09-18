class ProjectService
  def sample(sample_size=1)
    issues = Issue
      .open_issues_with_unique_permitted_repositories
      .random_order_weighted_by_quality
      .limit(sample_size)
    projects = issues.map {|issue| Project.new(issue)}
    projects
  end
end
