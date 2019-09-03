# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PullRequestService do
  let(:user) { FactoryBot.create(:user) }
  let(:scoreboard) { PullRequestService.new(user) }

  describe '.new' do
    context 'valid arguments' do
      it 'returns a UserScoreBoard' do
        expect(scoreboard).to_not be(nil)
      end
    end

    context 'invalid arguments' do
      it 'raises an error ' do
        expect { PullRequestService.new(123, 'abc') }
          .to raise_error(ArgumentError)
      end
    end

    context 'no arguments provided' do
      it 'raises an error ' do
        expect { PullRequestService.new }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#all' do
    before do
      mock_authentication(uid: user.uid)
    end

    context 'it ruturns an array of PullRequest objects' do
    end
  end

  describe '#all_by_state' do
    context 'it returns a pull request hash with state keys' do
      it 'will filter each pull request and assign it to the right key' do
      end
    end
  end

  describe '#github_pull_requests' do
    context 'the GithubPullRequestService is called' do
      it 'makes a new GithubPullRequestService' do
      end

      it 'returns an array of GithubPullRequests objects' do
      end
    end
  end

  describe '#filtered_github_pull_requests' do
    context 'given an array of 4 pull requests' do
      context 'pull requests with valid dates and valid labels' do
        it 'filters and returns all 4 PRs', vcr: { record: :new_episodes } do
          prs = pull_request_data(PR_DATA[:valid_array])
          expect(scoreboard.filtered_github_pull_requests(prs).length).to eq(4)
        end
      end

      context 'pull requests with 2 invalid dates & valid labels' do
        it 'filters and returns 2 of the PRs', vcr: { record: :new_episodes } do
          prs = pull_request_data(PR_DATA[:array_with_invalid_dates])
          expect(scoreboard.filtered_github_pull_requests(prs).length).to eq(2)
        end
      end

      context 'pull_requests with valid dates & 2 invalid labels' do
        it 'filters and returns 2 of the PRs', vcr: { record: :new_episodes } do
          prs = pull_request_data(PR_DATA[:array_with_invalid_labels])
          expect(scoreboard.filtered_github_pull_requests(prs).length).to eq(2)
        end
      end

      context 'pull_requests with 4 invalid dates & invalid labels' do
        it 'filters & returns an empty array', vcr: { record: :new_episodes } do
          prs = pull_request_data(PR_DATA[:invalid_array])
          expect(scoreboard.filtered_github_pull_requests(prs).length).to eq(0)
        end
      end
    end
  end

  describe '#score' do
    # subject { PullRequestService.new(user) }
    # context 'a new user with no pull requests' do
    #   it 'returns 0', vcr: { record: :new_episodes } do
    #     expect(subject.score).to eq(0)
    #   end
    # end
    #
    # context 'it counts the amount of pull requests' do
    #   it 'returns an integer', vcr: { record: :new_episodes } do
    #     expect(subject.score).to be_a(Integer)
    #   end
    # end
  end
end
