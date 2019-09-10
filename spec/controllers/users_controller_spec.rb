# frozen_string_literal: true


# relevant PRs are NOT showing up on response for profile page
require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:pr_service) { PullRequestService.new(user) }
  let(:controller) { UsersController.new }

  describe '#show' do
    before do
      mock_authentication(uid: user.uid)
      login
    end

    context 'a user has more than 4 eligible pull requests' do
      before do
        pull_requestss = pull_request_data(PR_DATA[:valid_array]).map do |pr|
          PullRequest.new(pr)
        end
        allow(user).to receive(:pull_requests).and_return(pull_requestss)
      end

      it 'returns 4 as the max score', vcr: { record: :new_episodes }  do
        get profile_path
        expect(response.body).to include('4 out of 4')
        expect(response).to be_successful

      end

      it 'does not show more than 4 eligible pull requests', vcr: { record: :new_episodes } do
        get profile_path
        fifth_eligible_pr = PR_DATA[:valid_array].last
        expect(response.body).to_not include(fifth_eligible_pr.title)
      end
    end

    context 'a user has no pull_requests' do
      before do
        allow(user).to receive(:pull_requests).and_return([])
      end

      it 'only displays progress', vcr: { record: :new_episodes }  do
        get profile_path
        expect(response.body).to include('0 out of 4')
      end
    end

    context 'a user has some eligible and invalid pull_requests' do
      before do
        pull_requestss = pull_request_data(PR_DATA[:invalid_array]).map do |pr|
          PullRequest.new(pr)
        end
        allow(user).to receive(:pull_requests).and_return(pull_requestss)
      end

      it 'calculates score of 3 eligible pull_requests', vcr: { record: :new_episodes }  do
        get profile_path
        expect(response.body).to include('3 out of 4')
      end

      it 'returns all pull requests', vcr: { record: :new_episodes }  do
        get profile_path
        invalid_pr = PR_DATA[:invalid_array].first
        expect(response.body).to include(invalid_pr.title)
      end
    end
  end
end
