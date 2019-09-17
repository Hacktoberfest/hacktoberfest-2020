# frozen_string_literal: true

require 'rails_helper'

describe HacktoberfestProjectImporter do
  describe '#import' do
    context 'Given a project' do
      it 'creates the corresponding issue, repository, and language' do
        repo_code_of_conduct_url = 'https://example.com/code_of_conduct'
        repo_database_id = 98_765
        repo_description = 'some clear repo description'
        repo_forks = 1
        repo_language = 'Java'
        repo_name = 'repo'
        repo_name_with_owner = "owner/#{repo_name}"
        repo_stars = 2
        repo_url = "https://github.com/#{repo_name_with_owner}"
        repo_watchers = 3
        issue_database_id = 12_345
        issue_number = 13
        issue_participants = 4
        issue_timeline_events = 5
        issue_title = 'Something is broken'
        issue_url = "#{repo_url}/issues/#{issue_number}"
        project = {
          issue_database_id: issue_database_id,
          issue_number: issue_number,
          issue_participants: issue_participants,
          issue_timeline_events: issue_timeline_events,
          issue_title: issue_title,
          issue_url: issue_url,
          repo_code_of_conduct_url: repo_code_of_conduct_url,
          repo_database_id: repo_database_id,
          repo_description: repo_description,
          repo_forks: repo_forks,
          repo_language: repo_language,
          repo_name: repo_name,
          repo_name_with_owner: repo_name_with_owner,
          repo_stars: repo_stars,
          repo_url: repo_url,
          repo_watchers: repo_watchers
        }

        importer = HacktoberfestProjectImporter.new
        importer.import(project)

        issue = Issue.last
        expect(issue.gh_database_id).to eq issue_database_id
        expect(issue.title).to eq issue_title
        expect(issue.number).to eq issue_number
        expect(issue.participants).to eq issue_participants
        expect(issue.timeline_events).to eq issue_timeline_events
        expect(issue.url).to eq issue_url
        repository = Repository.last
        expect(repository.code_of_conduct_url).to eq repo_code_of_conduct_url
        expect(repository.forks).to eq repo_forks
        expect(repository.full_name).to eq repo_name_with_owner
        expect(repository.gh_database_id).to eq repo_database_id
        expect(repository.name).to eq repo_name
        expect(repository.stars).to eq repo_stars
        expect(repository.url).to eq repo_url
        expect(repository.watchers).to eq repo_watchers
        language = Language.last
        expect(language.name).to eq repo_language
      end
    end

    context 'Given a project for an existing repository without a language' do
      it 'updates the repository language' do
        repo_code_of_conduct_url = 'https://example.com/code_of_conduct'
        repo_database_id = 98_765
        repo_description = 'some clear repo description'
        repo_forks = 1
        repo_language = 'Java'
        repo_name = 'repo'
        repo_name_with_owner = "owner/#{repo_name}"
        repo_stars = 2
        repo_url = "https://github.com/#{repo_name_with_owner}"
        repo_watchers = 3
        repository_without_language = create(
          :repository,
          language: nil,
          code_of_conduct_url: repo_code_of_conduct_url,
          description: repo_description,
          forks: repo_forks,
          gh_database_id: repo_database_id,
          name: repo_name,
          full_name: repo_name_with_owner,
          stars: repo_stars,
          url: repo_url,
          watchers: repo_watchers
        )
        issue_database_id = 12_345
        issue_number = 13
        issue_participants = 4
        issue_timeline_events = 5
        issue_title = 'Something is broken'
        issue_url = "#{repo_url}/issues/#{issue_number}"
        project = {
          issue_database_id: issue_database_id,
          issue_number: issue_number,
          issue_participants: issue_participants,
          issue_timeline_events: issue_timeline_events,
          issue_title: issue_title,
          issue_url: issue_url,
          repo_code_of_conduct_url: repo_code_of_conduct_url,
          repo_database_id: repo_database_id,
          repo_description: repo_description,
          repo_forks: repo_forks,
          repo_language: repo_language,
          repo_name: repo_name,
          repo_name_with_owner: repo_name_with_owner,
          repo_stars: repo_stars,
          repo_url: repo_url,
          repo_watchers: repo_watchers
        }

        importer = HacktoberfestProjectImporter.new
        importer.import(project)

        issue = Issue.last
        expect(issue.gh_database_id).to eq issue_database_id
        expect(issue.title).to eq issue_title
        expect(issue.number).to eq issue_number
        expect(issue.participants).to eq issue_participants
        expect(issue.timeline_events).to eq issue_timeline_events
        expect(issue.url).to eq issue_url
        repository = issue.repository
        expect(repository.code_of_conduct_url).to eq repo_code_of_conduct_url
        expect(repository.forks).to eq repo_forks
        expect(repository.full_name).to eq repo_name_with_owner
        expect(repository.gh_database_id).to eq repo_database_id
        expect(repository.name).to eq repo_name
        expect(repository.stars).to eq repo_stars
        expect(repository.url).to eq repo_url
        expect(repository.watchers).to eq repo_watchers
        language = repository.language
        expect(language.name).to eq repo_language
        expect(repository_without_language.id).to eq repository.id
      end
    end
  end

  describe '#import_all' do
    context 'Given an array of projects' do
      it 'creates the corresponding issues, repositories, and languages' do
        shared_repo_code_of_conduct_url = 'https://example.com/code_of_conduct'
        shared_repo_database_id = 222
        shared_repo_description = 'description of shared repo'
        shared_repo_forks = 1
        shared_repo_name = 'shared_repo'
        shared_repo_name_with_owner = "shared_project/#{shared_repo_name}"
        shared_repo_language = 'C#'
        shared_repo_stars = 2
        shared_repo_url = "https://github.com/#{shared_repo_name_with_owner}"
        shared_repo_watchers = 3
        other_repo_code_of_conduct_url = 'https://example.com/code_of_revenge'
        other_repo_database_id = 333
        other_repo_forks = 24
        other_repo_name = 'other_repo'
        other_repo_name_with_owner = "other_project/#{other_repo_name}"
        other_repo_description = 'description of other repo'
        other_repo_stars = 25
        other_repo_url = "https://github.com/#{other_repo_name_with_owner}"
        other_repo_watchers = 26
        other_repo_language = 'Python'
        shared_issue_database_id_1 = 42
        shared_issue_title_1 = 'Something is broken'
        shared_issue_number_1 = 101
        shared_issue_participants_1 = 11
        shared_issue_timeline_events_1 = 12
        shared_issue_url_1 = "#{shared_repo_url}/issues/#{shared_issue_number_1}"
        shared_issue_database_id_2 = 43
        shared_issue_number_2 = 102
        shared_issue_participants_2 = 22
        shared_issue_timeline_events_2 = 21
        shared_issue_title_2 = 'Something else is broken'
        shared_issue_url_2 = "#{shared_repo_url}/issues/#{shared_issue_number_2}"
        other_issue_database_id = 9999
        other_issue_participants = 9
        other_issue_timeline_events = 91
        other_issue_title = 'Something unrelated is broken'
        other_issue_number = 99
        other_issue_url = "#{other_repo_url}/issues/#{other_issue_number}"
        shared_project_1 = {
          issue_database_id: shared_issue_database_id_1,
          issue_number: shared_issue_number_1,
          issue_participants: shared_issue_participants_1,
          issue_timeline_events: shared_issue_timeline_events_1,
          issue_title: shared_issue_title_1,
          issue_url: shared_issue_url_1,
          repo_code_of_conduct_url: shared_repo_code_of_conduct_url,
          repo_database_id: shared_repo_database_id,
          repo_description: shared_repo_description,
          repo_forks: shared_repo_forks,
          repo_language: shared_repo_language,
          repo_name: shared_repo_name,
          repo_name_with_owner: shared_repo_name_with_owner,
          repo_stars: shared_repo_stars,
          repo_url: shared_repo_url,
          repo_watchers: shared_repo_watchers
        }
        shared_project_2 = {
          issue_database_id: shared_issue_database_id_2,
          issue_number: shared_issue_number_2,
          issue_participants: shared_issue_participants_2,
          issue_timeline_events: shared_issue_timeline_events_2,
          issue_title: shared_issue_title_2,
          issue_url: shared_issue_url_2,
          repo_code_of_conduct_url: shared_repo_code_of_conduct_url,
          repo_database_id: shared_repo_database_id,
          repo_description: shared_repo_description,
          repo_forks: shared_repo_forks,
          repo_language: shared_repo_language,
          repo_name: shared_repo_name,
          repo_name_with_owner: shared_repo_name_with_owner,
          repo_stars: shared_repo_stars,
          repo_url: shared_repo_url,
          repo_watchers: shared_repo_watchers
        }
        other_project = {
          issue_database_id: other_issue_database_id,
          issue_number: other_issue_number,
          issue_participants: other_issue_participants,
          issue_timeline_events: other_issue_timeline_events,
          issue_title: other_issue_title,
          issue_url: other_issue_url,
          repo_code_of_conduct_url: other_repo_code_of_conduct_url,
          repo_database_id: other_repo_database_id,
          repo_forks: other_repo_forks,
          repo_description: other_repo_description,
          repo_language: other_repo_language,
          repo_name: other_repo_name,
          repo_name_with_owner: other_repo_name_with_owner,
          repo_stars: other_repo_stars,
          repo_url: other_repo_url,
          repo_watchers: other_repo_watchers
        }
        projects = [shared_project_1, shared_project_2, other_project]

        importer = HacktoberfestProjectImporter.new
        importer.import_all(projects)

        expect(Language.all.map(&:name)).to match_array [shared_repo_language, other_repo_language]
        expect(Repository.all.map(&:gh_database_id)).to match_array [shared_repo_database_id, other_repo_database_id]
        expect(Issue.all.map(&:gh_database_id)).to match_array [shared_issue_database_id_1, shared_issue_database_id_2, other_issue_database_id]
      end
    end
  end
end
