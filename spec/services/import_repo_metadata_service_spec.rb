# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImportRepoMetadataService do
  describe '.call' do
    # so there is a user to grab a token from
    let!(:user) { FactoryBot.create(:user) }
    context 'The repo does not yet exist as a RepoStat' do
      before do
        allow_any_instance_of(Octokit::Client)
          .to receive(:repo).and_return("test": 1)
      end

      it 'creates one repostat' do
        ImportRepoMetadataService.call(1)

        expect(RepoStat.count).to eq(1)
      end

      it 'creates the correct repostat' do
        ImportRepoMetadataService.call(1)

        expect(RepoStat.last.repo_id).to eq('1')
      end

      it 'creates a repostat with the correct data' do
        ImportRepoMetadataService.call(1)

        expect(RepoStat.last.data).to eq('test' => 1)
      end
    end

    context 'The repo already exists as a RepoStat' do
      before do
        allow_any_instance_of(Octokit::Client)
          .to receive(:repo).and_return("test": 2)

        RepoStat.create(repo_id: 1, data: { "test": 1 })
      end

      it 'does not create a new repostat' do
        ImportRepoMetadataService.call(1)

        expect(RepoStat.count).to eq(1)
      end

      it 'updates the repostat' do
        ImportRepoMetadataService.call(1)

        expect(RepoStat.last.data).to eq({"test"=>2})
      end
    end
  end
end
