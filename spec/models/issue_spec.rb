# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Issue, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:repository) }
  end

  describe 'validations' do
    subject { build(:issue) }
    it { is_expected.to validate_presence_of(:gh_database_id) }
    it { is_expected.to validate_uniqueness_of(:gh_database_id) }
    it { is_expected.to validate_presence_of(:number) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:url) }
    it do
      is_expected.to validate_uniqueness_of(:number).scoped_to(:repository_id)
    end
  end

  describe '.open_issues_with_permitted_repositories' do
    it 'returns all open issues belonging to permitted repos' do
      language = create(:language)
      permitted_repo = create(:repository, language: language, banned: false)
      first_open_issue_for_permitted_repo = create(
        :issue,
        repository: permitted_repo,
        open: true
      )
      second_open_issue_for_permitted_repo = create(
        :issue,
        repository: permitted_repo,
        open: true
      )
      closed_issue_for_permitted_repo = create(
        :issue,
        repository: permitted_repo,
        open: false
      )
      banned_repo = create(:repository, language: language, banned: true)
      open_issue_for_banned_repo = create(
        :issue,
        repository: banned_repo,
        open: true
      )

      issues = Issue.open_issues_with_permitted_repositories

      expect(issues).not_to include closed_issue_for_permitted_repo
      expect(issues).not_to include open_issue_for_banned_repo
      expect(issues).to include first_open_issue_for_permitted_repo
      expect(issues).to include second_open_issue_for_permitted_repo
    end
  end

  describe '.open_issues_with_unique_permitted_repositories' do
    it 'returns open issues belonging to permitted repos' do
      language = create(:language)
      permitted_repo = create(:repository, language: language, banned: false)
      open_issue_for_permitted_repo = create(
        :issue,
        repository: permitted_repo,
        open: true
      )
      closed_issue_for_permitted_repo = create(
        :issue,
        repository: permitted_repo,
        open: false
      )
      banned_repo = create(:repository, language: language, banned: true)
      open_issue_for_banned_repo = create(
        :issue,
        repository: banned_repo,
        open: true
      )

      issues = Issue.open_issues_with_unique_permitted_repositories

      expect(issues).not_to include closed_issue_for_permitted_repo
      expect(issues).not_to include open_issue_for_banned_repo
      expect(issues).to include open_issue_for_permitted_repo
    end

    it 'returns only one issue per repo' do
      language = create(:language)
      permitted_repo = create(:repository, language: language, banned: false)
      number_of_open_issues_for_permitted_repo = 2
      create_list(
        :issue,
        number_of_open_issues_for_permitted_repo,
        repository: permitted_repo,
        open: true
      )

      issues = Issue.open_issues_with_unique_permitted_repositories

      expect(issues.to_a.count).to eq 1
    end

    it 'returns a random issue per repo' do
      language = create(:language)
      permitted_repo = create(:repository, language: language, banned: false)
      first_issue = create(
        :issue,
        repository: permitted_repo,
        open: true
      )
      second_issue = create(
        :issue,
        repository: permitted_repo,
        open: true
      )

      first_issue_selections = 0
      second_issue_selections = 0
      many = 20
      many.times do
        selection = Issue.open_issues_with_unique_permitted_repositories
                         .to_a.first
        case selection
        when first_issue
          first_issue_selections += 1
        when second_issue
          second_issue_selections += 1
        end
      end

      expect(first_issue_selections).to be > 1
      expect(second_issue_selections).to be > 1
    end
  end
end
