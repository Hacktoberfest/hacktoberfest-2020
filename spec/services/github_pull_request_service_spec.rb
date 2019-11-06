# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GithubPullRequestService do
  describe '#pull_requests' do
    context 'user was found' do
      let(:user) { FactoryBot.create(:user, uid: 7_976_757) }
      let(:github_pull_request_service) { GithubPullRequestService.new(user) }

      it 'returns an array of GithubPullRequests', :vcr do
        expect(github_pull_request_service.pull_requests)
          .to all(be_instance_of(GithubPullRequest))
      end
    end

    context 'user was not found' do
      let(:user) { FactoryBot.create(:user, uid: 56_205_871) }
      let(:github_pull_request_service) { GithubPullRequestService.new(user) }

      it 'raises a UserNotFoundOnGithubError', :vcr do
        expect { github_pull_request_service.pull_requests }
          .to raise_error(GithubPullRequestService::UserNotFoundOnGithubError)
      end
    end
  end
end
