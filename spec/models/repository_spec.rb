require 'rails_helper'

RSpec.describe Repository, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:language) }
  end

  describe 'validations' do
    subject { build(:repository) }
    it { is_expected.to validate_presence_of(:full_name) }
    it { is_expected.to validate_presence_of(:gh_database_id) }
    it { is_expected.to validate_uniqueness_of(:gh_database_id) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:url) }
    it { is_expected.to validate_uniqueness_of(:url) }
  end

  describe '#description' do
    context 'Given a description that is greater than the maximum length' do
      it 'truncates the description' do
        repository = build(:repository)
        maximum_length = 180
        repository.description = "*"*(maximum_length*2)
        repository.save

        expect(repository).to be_valid

        repository.reload
        expect(repository.description.length).to eq maximum_length
      end
    end

    context 'Given a description that is less than the maximum length' do
      it 'does not truncate the description' do
        maximum_length = 180
        original_description = "*"*(maximum_length-1)
        repository = build(:repository)
        repository.description = original_description
        repository.save

        expect(repository).to be_valid

        repository.reload
        expect(repository.description).to eq original_description
      end
    end

    context 'Given no description' do
      it 'is valid' do
        repository = build(:repository)
        repository.description = nil
        repository.save

        expect(repository).to be_valid
      end
    end
  end

  describe '.excluding_hacktoberfest_repos' do
    it 'returns only repositories that do not have hacktoberfest in the name' do
      create(:repository, full_name: 'foo/HacktoberFest')
      create(:repository, full_name: 'foo/HACKTOBERFEST')
      create(:repository, full_name: 'foo/hacktoberfest')
      create(:repository, full_name: 'Hacktoberfest20xx/foo')
      good_repo = create(:repository)

      result = Repository.excluding_hacktoberfest_repos

      expect(result).to eq [good_repo]
    end
  end


  describe '.total_count' do
    it 'returns total count of all repositories with valid pull requests' do
      repo_with_valid_prs = create(:repository)
      repos_with_valid_prs = [repo_with_valid_prs]
      repo_without_valid_prs = create(:repository)
      user = create(:user)
      create(:pull_request, user: user, repo: repo_with_valid_prs, is_valid: true)
      create(:pull_request, user: user, repo: repo_without_valid_prs, is_valid: false)

      expect(Repository.total_count).to eql repos_with_valid_prs.count
    end
  end
end
