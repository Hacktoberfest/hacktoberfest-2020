# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImportOnePrMetadataService do
  describe '.call' do
    # so a random provider token can be fetched:
    let!(:user) { FactoryBot.create(:user) }

    context 'Octokit returns pr data' do
      before do
        allow_any_instance_of(Octokit::Client)
          .to receive(:pull_request).and_return(
            node_id: 'test', data: 'test-data-1'
          )
      end

      context 'the PRStat is absent in the PR stats table' do
        it 'creates a PRStat' do
          ImportOnePrMetadataService.call(
            'https://github.com/raise-dev/hacktoberfest-test/pulls/15'
          )

          expect(PRStat.count).to eq(1)
        end
      end

      context 'the PRStat is present in the PR stats table, but outdated' do
        let!(:existing_stat) do
          PRStat.create(pr_id: 'test', data:
            { 'node_id' => 'test', 'data' => 'test-data-1' })
        end

        before do
          allow_any_instance_of(Octokit::Client)
            .to receive(:pull_request).and_return(
              node_id: 'test', data: 'updated-data'
            )

          ImportOnePrMetadataService.call(
            'https://github.com/raise-dev/hacktoberfest-test/pulls/15'
          )
        end

        it 'does not create another PR Stat' do
          expect(PRStat.count).to eq(1)
        end

        it 'updates the existing pr stat' do
          expect(PRStat.first.data).to eq(
            'node_id' => 'test', 'data' => 'updated-data'
          )
        end
      end
    end
  end
end
