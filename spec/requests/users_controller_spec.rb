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
  let(:controller) { UsersController.new }

  before do
    allow_any_instance_of(TokenValidatorService)
      .to receive(:valid?).and_return(true)
  end

  describe '#show' do
    before do
      mock_authentication(uid: user.uid)
      allow_any_instance_of(SegmentService).to receive(:identify)
      allow_any_instance_of(SegmentService).to receive(:track)

      allow_any_instance_of(UserEmailService).to receive(:emails)
        .and_return(['test@mail.com'])

      login
    end

    context 'waiting user has 4 eligible PRs & has been waiting for 7+ days' do
      before do
        stub_helper(PR_DATA[:mature_array])
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

    context 'a user has more than 4 waiting pull requests' do
      before do
        stub_helper(PR_DATA[:large_immature_array])
      end

      include_examples 'tries transition'

      it 'displays a complete progress bar', :vcr do
        get profile_path
        expect(response.body).to include('progress-state-4')
        expect(response).to be_successful
      end

      it 'transitions the user to the waiting state', :vcr do
        get profile_path
        user.reload
        expect(user.state).to eq('waiting')
      end
    end

    context 'a user has no pull_requests' do
      before do
        stub_helper([])
      end

      include_examples 'tries transition'

      it 'displays an empty progress bar', :vcr do
        get profile_path
        expect(response.body).to include('progress-state-0')
      end

      it 'keeps the user in the registered state', :vcr do
        get profile_path
        user.reload
        expect(user.state).to eq('registered')
      end
    end

    context 'a user has some eligible and invalid pull_requests' do
      before do
        stub_helper(PR_DATA[:array_with_invalid_labels])
      end

      include_examples 'tries transition'

      it 'displays a progress bar of 75%', :vcr do
        get profile_path
        expect(response.body).to include('progress-state-3')
      end

      it 'returns all pull requests', :vcr do
        get profile_path
        invalid_pr = PR_DATA[:invalid_array].first
        expect(response.body).to include(invalid_pr['title'])
      end
    end

    context 'a new user' do
      let(:user) { FactoryBot.create(:user, :new) }

      context 'hacktoberfest is active' do
        it 'redirects to the register_path' do
          get profile_path
          expect(response).to redirect_to(register_path)
        end
      end

      context 'hacktoberfest has ended' do
        before { travel_to Time.zone.parse(ENV['END_DATE']) + 8.days }

        it 'renders the the hacktoberfest ended page' do
          get profile_path
          expect(response.body).to include('Registrations are now closed.')
        end

        after { travel_back }
      end
    end
  end

  def stub_helper(arr_type)
    PullRequest.delete_all
    allow_any_instance_of(PullRequestService)
      .to receive(:github_pull_requests)
      .and_return(pull_request_data(arr_type))
  end
end
