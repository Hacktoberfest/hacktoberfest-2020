# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApiController, type: :request do
  before do
    allow(UserPullRequestSegmentUpdaterService)
      .to receive(:call).and_return(true)
  end

  describe '#state' do
    context 'unauthenticated' do
      context 'non-existent user' do
        it 'returns not-authorized' do
          get api_state_path(user: 'aaaa')

          expect(response.body).to eq('not-authorized')
        end
      end

      context 'incomplete user' do
        let(:user) { FactoryBot.create(:user) }

        it 'returns not-authorized' do
          get api_state_path(user: user.uid)

          expect(response.body).to eq('not-authorized')
        end
      end

      context 'complete user' do
        let(:user) { FactoryBot.create(:user, :completed) }

        it 'returns not-authorized' do
          get api_state_path(user: user.uid)

          expect(response.body).to eq('not-authorized')
        end
      end
    end

    context 'authenticated' do
      context 'non-existent user' do
        it 'returns not-found' do
          get api_state_path(user: 'aaaa'),
              headers: { 'Authorization' => ENV.fetch('HACKTOBERFEST_API_KEY') }

          expect(response.body).to eq('not-found')
        end
      end

      context 'incomplete user' do
        let(:user) { FactoryBot.create(:user) }

        it 'returns registered' do
          get api_state_path(user: user.uid),
              headers: { 'Authorization' => ENV.fetch('HACKTOBERFEST_API_KEY') }

          expect(response.body).to eq('registered')
        end
      end

      context 'complete user' do
        let(:user) { FactoryBot.create(:user, :completed) }

        it 'returns completed' do
          get api_state_path(user: user.uid),
              headers: { 'Authorization' => ENV.fetch('HACKTOBERFEST_API_KEY') }

          expect(response.body).to eq('completed')
        end
      end
    end
  end
end
