# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'tries transition' do
  it 'tries to transition the user' do
    expect(TryUserTransitionService).to receive(:call).and_return(true)
    get profile_path
  end
end

RSpec.describe UsersController, type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:pr_service) { PullRequestService.new(current_user) }
  let(:controller) { UsersController.new }

  describe '#show' do
    before do
      mock_authentication(uid: user.uid)
      login
    end

    context 'a waiting user has 4 mature pull_requests' do
      before do
        prs = pull_request_data(PR_DATA[:mature_array]).map do |pr|
          PullRequest.new(pr)
        end

        allow_any_instance_of(User).to receive(:pull_requests).and_return(prs)
        allow_any_instance_of(User)
          .to receive(:eligible_pull_requests_count).and_return(4)
        allow_any_instance_of(User)
          .to receive(:mature_pull_requests_count).and_return(4)

        user.wait
        mock_authentication(uid: user.uid)
        login
      end

      it 'transitions the user to the completed state', :vcr do
        get profile_path
        user.reload
        expect(user.state).to eq('completed')
      end
    end

    context 'a user has more than 4 eligible pull requests' do
      before do
        prs = pull_request_data(PR_DATA[:valid_array]).map do |pr|
          PullRequest.new(pr)
        end

        allow_any_instance_of(User).to receive(:pull_requests).and_return(prs)
        allow_any_instance_of(User).to receive(:score).and_return(4)
      end

      include_examples 'tries transition'

      it 'returns 4 as the max score', :vcr do
        get profile_path
        expect(response.body).to include('4 out of 4')
        expect(response).to be_successful
      end

      it 'only shows 4 valid pull requests', :vcr do
        get profile_path
        fifth_eligible_pr = PR_DATA[:valid_array].last
        expect(response.body).to_not include(fifth_eligible_pr['title'])
      end

      it 'transitions the user to the waiting state', :vcr do
        allow_any_instance_of(User)
          .to receive(:eligible_pull_requests_count).and_return(4)

        get profile_path
        user.reload
        expect(user.state).to eq('waiting')
      end
    end

    context 'a user has no pull_requests' do
      before do
        allow_any_instance_of(User).to receive(:pull_requests).and_return([])
        allow_any_instance_of(User).to receive(:score).and_return(0)
      end

      include_examples 'tries transition'

      it 'only displays progress', :vcr do
        get profile_path
        expect(response.body).to include('0 out of 4')
      end

      it 'keeps the user in the registered state', :vcr do
        allow_any_instance_of(User)
          .to receive(:eligible_pull_requests_count).and_return(0)

        get profile_path
        user.reload
        expect(user.state).to eq('registered')
      end
    end

    context 'a user has some eligible and invalid pull_requests' do
      before do
        prs = pull_request_data(PR_DATA[:invalid_array]).map do |pr|
          PullRequest.new(pr)
        end
        allow_any_instance_of(User).to receive(:pull_requests).and_return(prs)
        allow_any_instance_of(User).to receive(:score).and_return(3)
      end

      include_examples 'tries transition'

      it 'calculates score of 3 valid PRs', :vcr do
        get profile_path
        expect(response.body).to include('3 out of 4')
      end

      it 'returns all pull requests', :vcr do
        get profile_path
        invalid_pr = PR_DATA[:invalid_array].first
        expect(response.body).to include(invalid_pr['title'])
      end
    end
  end
end
