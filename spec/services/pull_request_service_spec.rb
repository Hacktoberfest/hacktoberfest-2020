# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PullRequestService do
  let(:user) { FactoryBot.create(:user) }
  let(:pr_service) { PullRequestService.new(user) }

  describe '.new' do
    context 'valid arguments' do
      it 'returns a UserScoreBoard' do
        expect(pr_service).to_not be(nil)
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

  describe '#all_by_state' do
    context 'given an array with valid pull_requests' do
      before do
        allow(pr_service)
          .to receive(:github_pull_requests)
          .and_return(pull_request_data(PR_DATA[:valid_array]))
      end

      it 'will categorize prs as eligible', vcr: { record: :new_episodes } do
        pr_service.all
        expect(pr_service.all_by_state[:eligible].length).to eq(4)
      end
    end

    context 'given an array with invalid pull_requests' do
      before do
        allow(pr_service)
          .to receive(:github_pull_requests)
          .and_return(pull_request_data(PR_DATA[:array_with_invalid_labels]))
      end

      it 'will categorize invalid prs', vcr: { record: :new_episodes } do
        pr_service.all
        expect(pr_service.all_by_state[:invalid].length).to eq(2)
      end
    end
  end

  describe '#all' do
    context 'given an array of 4 pull requests' do
      context 'pull requests with valid dates and valid labels' do
        before do
          allow(pr_service)
            .to receive(:github_pull_requests)
            .and_return(pull_request_data(PR_DATA[:valid_array]))
        end
        it 'filters and returns all 4 PRs', vcr: { record: :new_episodes } do
          expect(pr_service.all.length).to eq(4)
        end
      end

      context 'pull requests with 2 invalid dates & valid labels' do
        before do
          allow(pr_service)
            .to receive(:github_pull_requests)
            .and_return(pull_request_data(PR_DATA[:array_with_invalid_dates]))
        end
        it 'filters and returns 2 of the PRs', vcr: { record: :new_episodes } do
          expect(pr_service.all.length).to eq(2)
        end
      end

      context 'pull_requests with valid dates & 2 invalid labels' do
        before do
          allow(pr_service)
            .to receive(:github_pull_requests)
            .and_return(pull_request_data(PR_DATA[:array_with_invalid_labels]))
        end
        it 'filters and returns 4 of the PRs', vcr: { record: :new_episodes } do
          expect(pr_service.all.length).to eq(4)
        end
      end

      context 'pull_requests with 4 invalid dates & invalid labels' do
        before do
          allow(pr_service)
            .to receive(:github_pull_requests)
            .and_return(pull_request_data(PR_DATA[:invalid_array]))
        end
        it 'filters & returns an empty array', vcr: { record: :new_episodes } do
          expect(pr_service.all.length).to eq(0)
        end
      end
    end
  end

  describe '#score' do
    context 'a new user with no eligible pull requests' do
      before do
        allow(pr_service)
          .to receive(:github_pull_requests)
          .and_return(pull_request_data(PR_DATA[:invalid_array]))
      end
      it 'returns 0', vcr: { record: :new_episodes } do
        pr_service.all
        pr_service.all_by_state
        expect(pr_service.score).to eq(0)
      end
    end

    context 'it counts the amount of pull requests' do
      before do
        allow(pr_service)
          .to receive(:github_pull_requests)
          .and_return(pull_request_data(PR_DATA[:valid_array]))
      end
      it 'returns the total', vcr: { record: :new_episodes } do
        pr_service.all
        pr_service.all_by_state
        expect(pr_service.score).to eq(4)
      end
    end
  end
end
