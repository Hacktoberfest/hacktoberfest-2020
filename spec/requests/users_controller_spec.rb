# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'tries transition' do
  it 'tries to transition the user', :vcr do
    expect(TryUserTransitionService).to receive(:call).and_return(true)
    get profile_path
  end
end

RSpec.describe UsersController, type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:pr_service) { PullRequestService.new(current_user) }
  let(:controller) { UsersController.new }

  before do
    allow_any_instance_of(TokenValidatorService).
      to receive(:valid?).and_return(true)
  end

  describe '#show' do
    before do
      mock_authentication(uid: user.uid)
      allow_any_instance_of(SegmentService).to receive(:identify)
      allow_any_instance_of(SegmentService).to receive(:track)

      allow(Hacktoberfest).to receive(:ended?).and_return(:false)
      allow(Hacktoberfest).to receive(:active?).and_return(:true)

      allow_any_instance_of(UserEmailService).to receive(:emails).and_return("test@mail.com")

      login
    end

    context 'a waiting user has 4 mature pull_requests and has been waiting for 7+ days' do
      before do
        prs = pull_request_data(PR_DATA[:mature_array]).map do |pr|
          PullRequest.new(pr)
        end

        allow_any_instance_of(User).to receive(:pull_requests).and_return(prs)
        allow_any_instance_of(User).to receive(:waiting_since).and_return(Date.today - 8)
        allow_any_instance_of(User)
          .to receive(:eligible_pull_requests_count).and_return(4)

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

      xit 'returns the complete progress bar', :vcr do
        get profile_path
        body.should have_css('div.progress-bar')
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

      xit 'only displays progress', :vcr do
        get profile_path
        body.should have_css('div.progress-bar')
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

      xit 'calculates score of 3 valid PRs', :vcr do
        get profile_path
        body.should have_css('div.progress-bar')
      end

      xit 'returns all pull requests', :vcr do
        get profile_path
        invalid_pr = PR_DATA[:invalid_array].first
        expect(response.body).to include(invalid_pr['title'])
      end
    end
  end
end
