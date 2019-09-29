# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HacktoberfestProjectQueryComposer do
  describe '.compose' do
    context 'When not given a cursor' do
      it 'returns a project graphql json query for the first set of results' do
        results_per_page = 1_000_000
        graphql_json_query_without_pagination = {
          query: HacktoberfestProjectQueryComposer::PROJECT_IMPORT_QUERY,
          variables: {
            queryString: 'state:open label:hacktoberfest',
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
        graphql_json_query_with_pagination = {
          query: HacktoberfestProjectQueryComposer::PROJECT_IMPORT_QUERY,
          variables: {
            queryString: 'state:open label:hacktoberfest',
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
        query_string = 'language:Ruby'
        graphql_json_query_with_pagination = {
          query: HacktoberfestProjectQueryComposer::PROJECT_IMPORT_QUERY,
          variables: {
            queryString: "state:open label:hacktoberfest #{query_string}",
            first: results_per_page,
          }
        }

        query = HacktoberfestProjectQueryComposer.compose(
          query_string: query_string,
          results_per_page: results_per_page,
          cursor: nil
        )

        expect(query).to eq graphql_json_query_with_pagination
      end
    end
  end
end
