# frozen_string_literal: true

require 'rails_helper'

 RSpec.describe 'GithubGraphqlApiClient' do
   let(:user) { FactoryBot.create(:user) }
   let(:github_graphql_client) do
     GithubGraphqlApiClient.new(access_token: user.provider_token)
   end

   describe '.new' do
    context 'valid arguments' do
      it 'returns a PullRequestFilterService' do
        expect(github_graphql_client).to_not be(nil)
      end
    end

     context 'invalid arguments' do
      it 'raises an error ' do
        expect { GithubGraphqlApiClient.new(fklds: 'abc') }.to
        raise_error(ArgumentError)
      end
    end

     context 'no arguments provided' do
      it 'raises an error ' do
        expect { GithubGraphqlApiClient.new }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#request' do
    context 'the request is succesful' do
      it 'returns hash with correct props', vcr: { record: :new_episodes } do
        response = github_graphql_client.request(mock_query)
        expect(response).to be_an_instance_of(Hashie::Mash)
      end
    end

     context 'bad request' do
      it 'returns a status 400 and raises an error' do
        Hacktoberfest.client('garbage query')
         expect(response).to raise_error(Faraday::BadRequest)
      end
    end

     context 'server error' do
      it 'returns a status 500 and raises an error' do
        Hacktoberfest.client(mock_query)
         expect(response).to raise_error(Faraday::ServerError)
      end
    end
  end
end
