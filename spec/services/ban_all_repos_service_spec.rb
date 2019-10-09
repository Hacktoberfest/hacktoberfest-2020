# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BanAllReposService do
  describe '.call' do
    let!(:repo_to_ban) { FactoryBot.create(:repository) }

    context 'Airtable provides a repo to ban' do
      before do
        allow(BanAllReposService).to receive(:repo_ids_to_ban)
          .and_return([repo_to_ban.gh_database_id])
        BanAllReposService.call
      end

      it 'bans the repo in our db' do
        expect(Repository.first.banned).to eq(true)
      end
    end
  end
end
