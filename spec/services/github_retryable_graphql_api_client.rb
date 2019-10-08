# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GithubRetryableGraphqlApiClient do
  describe '#request' do
    context 'the first request is successful' do
      before do
        allow_any_instance_of(GithubGraphqlApiClient)
          .to receive(:request).and_return(Hashie::Mash.new)
      end

      it 'returns the results from the API' do
        client = GithubRetryableGraphqlApiClient.new(access_token: 'some-token')
        response = client.request(mock_query)
        expect(response).to be_an_instance_of(Hashie::Mash)
      end
    end

    context 'the first two requests fail with 502 and the third succeeds' do
      before do
        response_values = [:raise, :raise, Hashie::Mash.new]
        allow_any_instance_of(GithubGraphqlApiClient)
          .to receive(:request) do
            v = response_values.shift
            if v == :raise
              e = Faraday::ClientError.new(
                'the server responded with status 502',
                status: 502
              )
              raise(e)
            else
              v
            end
          end

        allow(GithubTokenService).to receive(:random)
          .and_return('random-one', 'random-two', 'random-three')
      end

      context 'retries is set to zero' do
        let(:client) do
          GithubRetryableGraphqlApiClient.new(access_token: 'some-token')
        end

        it 'raises an error' do
          expect { client.request(mock_query) }
            .to raise_error(Faraday::ClientError)
        end
      end

      context 'retries is set to three' do
        let(:client) do
          GithubRetryableGraphqlApiClient.new(
            access_token: 'some-token', retries: 3
          )
        end

        it 'returns the results from the API' do
          response = client.request(mock_query)
          expect(response).to be_an_instance_of(Hashie::Mash)
        end
      end
    end

    context 'the first two requests fail with 500 and the third succeeds' do
      before do
        response_values = [:raise, :raise, Hashie::Mash.new]
        allow_any_instance_of(GithubGraphqlApiClient)
          .to receive(:request) do
            v = response_values.shift
            if v == :raise
              e = Faraday::ClientError
                  .new('the server responded with status 500', status: 500)
              raise(e)
            else
              v
            end
          end

        allow(GithubTokenService).to receive(:random)
          .and_return('random-one', 'random-two', 'random-three')
      end

      context 'retries is set to zero' do
        let(:client) do
          GithubRetryableGraphqlApiClient.new(access_token: 'some-token')
        end

        it 'raises an error' do
          expect { client.request(mock_query) }
            .to raise_error(Faraday::ClientError)
        end
      end

      context 'retries is set to three' do
        let(:client) do
          GithubRetryableGraphqlApiClient.new(
            access_token: 'some-token',
            retries: 3
          )
        end

        it 'raises an error' do
          expect { client.request(mock_query) }
            .to raise_error(Faraday::ClientError)
        end
      end
    end
  end
end
