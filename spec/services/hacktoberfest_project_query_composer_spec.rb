# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HacktoberfestProjectQueryComposer do
  # rubocop:disable Metrics/LineLength
  describe '.compose' do
    context 'When not given a cursor' do
      it 'returns a project graphql json query for the first set of results' do
        results_per_page = 1_000_000
        date = Time.zone.now.strftime('%Y-%m-%d')
        graphql_json_query_without_pagination = {
          query: HacktoberfestProjectQueryComposer::PROJECT_IMPORT_QUERY,
          variables: {
            queryString: 'state:open label:hacktoberfest no:assignee created:' + date,
            first: results_per_page
          }
        }

        query = HacktoberfestProjectQueryComposer.compose(
          results_per_page: results_per_page,
          cursor: nil
        )

        expect(query).to eq graphql_json_query_without_pagination
      end
    end

    context 'When given a cursor' do
      it 'returns a project graphql json query paginated to the cursor' do
        results_per_page = 1_000_000
        cursor = 'a_dog_eared_page'
        date = Time.zone.now.strftime('%Y-%m-%d')
        graphql_json_query_with_pagination = {
          query: HacktoberfestProjectQueryComposer::PROJECT_IMPORT_QUERY,
          variables: {
            queryString: 'state:open label:hacktoberfest no:assignee created:' + date,
            first: results_per_page,
            after: cursor
          }
        }

        query = HacktoberfestProjectQueryComposer.compose(
          results_per_page: results_per_page,
          cursor: cursor
        )

        expect(query).to eq graphql_json_query_with_pagination
      end
    end

    context 'When given a query string' do
      it 'returns a project graphql json query with the query string' do
        results_per_page = 1_000_000
        q_str = 'language:Ruby'
        date = Time.zone.now.strftime('%Y-%m-%d')
        graphql_json_query_with_pagination = {
          query: HacktoberfestProjectQueryComposer::PROJECT_IMPORT_QUERY,
          variables: {
            queryString: "state:open label:hacktoberfest no:assignee #{q_str} created:" + date,
            first: results_per_page
          }
        }

        query = HacktoberfestProjectQueryComposer.compose(
          query_string: q_str,
          results_per_page: results_per_page,
          cursor: nil
        )

        expect(query).to eq graphql_json_query_with_pagination
      end
    end
  end
  # rubocop:enable Metrics/LineLength
end
