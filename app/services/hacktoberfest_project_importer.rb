# frozen_string_literal: true

class HacktoberfestProjectImporter
  def import_all(projects)
    projects.each do |project|
      import(project)
    end
  end

  def import(project)
    language = import_language(project)
    repository = import_repository(project, language)
    import_issue(project, repository)
  end

  private

  def import_language(project)
    Language.find_or_create_by!(name: project[:repo_language])
  end

  def import_repository(project, language)
    unless spammy?(project[:repo_database_id])
      repository = Repository.find_or_initialize_by(
        gh_database_id: project[:repo_database_id]
      )
    end
    unless repository.persisted?
      repository.code_of_conduct_url = project[:repo_code_of_conduct_url]
      repository.description = project[:repo_description]
      repository.forks = project[:repo_forks]
      repository.full_name = project[:repo_name_with_owner]
      repository.gh_database_id = project[:repo_database_id]
      repository.name = project[:repo_name]
      repository.stars = project[:repo_stars]
      repository.url = project[:repo_url]
      repository.watchers = project[:repo_watchers]
      repository.language = language
      repository.save!
    end
    if repository.language.blank?
      repository.language = language
      repository.save!
    end
    repository
  end

  def import_issue(project, repository)
    issue = Issue.find_or_initialize_by(
      gh_database_id: project[:issue_database_id]
    )
    unless issue.persisted?
      issue = Issue.new
      issue.gh_database_id = project[:issue_database_id]
      issue.number = project[:issue_number]
      issue.participants = project[:issue_participants]
      issue.timeline_events = project[:issue_timeline_events]
      issue.title = project[:issue_title]
      issue.url = project[:issue_url]
      issue.repository = repository
      issue.save!
    end
    issue
  end

  def spammy?(repo_id)
    SpamRepositoryService.call(repo_id)
  end
end
