# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GithubErrorHandler do
  let(:user) { FactoryBot.create(:user) }
  describe '.process_github_error' do
    context 'The error is UserNotFoundOnGithubError' do
      let(:error) { GithubPullRequestService::UserNotFoundOnGithubError.new }

      it 'calls process_user_missing_error' do
        expect(GithubErrorHandler)
          .to receive(:process_user_missing_error).with(error, user)

        GithubErrorHandler.process_github_error(error, user)
      end

      it 'correctly updates the last_error column on the user' do
        GithubErrorHandler.process_github_error(error, user)

        expect(user.last_error).to eq(error.class.to_s)
      end
    end

    context 'The error is Octokit::AccountSuspended' do
      let(:error) { Octokit::AccountSuspended.new }

      it 'calls process_user_missing_error' do
        expect(GithubErrorHandler)
          .to receive(:process_user_missing_error).with(error, user)

        GithubErrorHandler.process_github_error(error, user)
      end

      it 'correctly updates the last_error column on the user' do
        GithubErrorHandler.process_github_error(error, user)

        expect(user.last_error).to eq(error.class.to_s)
      end
    end

    context 'The error is an unhandled error' do
      let(:error) { StandardError.new }

      it 'raises the error' do
        expect { GithubErrorHandler.process_github_error(error, user) }
          .to raise_error(StandardError)
      end
    end
  end

  describe '.process_user_missing_error' do
    let(:error) { GithubPullRequestService::UserNotFoundOnGithubError.new }
    it 'destroys the UserStat' do
      UserStat.create(user_id: user.id, data: user)

      GithubErrorHandler.process_user_missing_error(error, user)

      expect(UserStat.count).to eq(0)
    end

    it 'deactivates the user' do
      # to pass user#deactivate validations
      allow(user)
        .to receive(:last_error).and_return('Octokit::AccountSuspended')

      GithubErrorHandler.process_user_missing_error(error, user)

      expect(user.state).to eq('inactive')
    end
  end
end
