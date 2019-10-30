# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PullRequestService do
  let(:user) { FactoryBot.create(:user) }
  let(:pr_service) { PullRequestService.new(user) }
  let(:user_with_receipt) { FactoryBot.create(:user, :winner_with_receipt) }
  let(:pr_service_for_user_w_receipt) do
    PullRequestService.new(user_with_receipt)
  end
  before { allow(SpamRepositoryService).to receive(:call).and_return(false) }

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

  describe '#all' do
    context 'a new user with no eligible pull requests' do
      before { stub_helper(PR_DATA[:invalid_array]) }

      it 'returns no ineligible prs' do
        expect(pr_service.all.count).to eq(0)
      end
    end

    context 'a user with eligible pull requests' do
      before { stub_helper(PR_DATA[:valid_array]) }

      it 'returns all the prs' do
        expect(pr_service.all.count).to eq(5)
      end
    end
  end

  describe '#eligible_prs' do
    context '5 pull requests with valid dates and valid labels' do
      before { stub_helper(PR_DATA[:valid_array]) }

      it 'filters and returns all 5 PRs' do
        expect(pr_service.eligible_prs.length).to eq(5)
      end
    end

    context '4 pull requests with 2 invalid dates' do
      before { stub_helper(PR_DATA[:array_with_invalid_dates]) }

      it 'filters and returns 2 of the PRs' do
        expect(pr_service.eligible_prs.length).to eq(2)
      end
    end

    context '5 pull requests with valid dates & 2 invalid labels' do
      before { stub_helper(PR_DATA[:array_with_invalid_labels]) }

      it 'filters and returns 3 of the PRs' do
        expect(pr_service.eligible_prs.length).to eq(3)
      end
    end

    context '4 pull_requests with 4 invalid dates & invalid labels' do
      before { stub_helper(PR_DATA[:invalid_array]) }

      it 'filters & returns an empty array' do
        expect(pr_service.eligible_prs.length).to eq(0)
      end
    end
  end

  describe '#scoring_pull_requests' do
    context 'a user with more than 4 eligible pull requests' do
      before { stub_helper(PR_DATA[:valid_array]) }
      it 'returns initial 4 eligible_prs' do
        expect(pr_service.scoring_pull_requests.count).to eq(4)
      end
    end

    context 'a user with with 2 eligible pull requests' do
      before { stub_helper(PR_DATA[:valid_array].first(2)) }
      it 'returns only 2 eligible_prs' do
        expect(pr_service.scoring_pull_requests.count).to eq(2)
      end
    end
  end

  describe '#non_scoring_pull_requests' do
    context 'a user that has completed or won' do
      before do
        allow(pr_service_for_user_w_receipt).to receive(:all)
          .and_return(pull_request_data(PR_DATA[:array_for_receipt_logic]))
      end

      it 'calls non_scoring_pull_requests' do
        expect(pr_service_for_user_w_receipt.non_scoring_pull_requests)
          .to eq(pr_service_for_user_w_receipt
                .non_scoring_pull_requests_for_completed_or_won)
      end
    end

    context 'a user that has not completed or won' do
      context 'with more than 4 eligible pull requests' do
        before { stub_helper(PR_DATA[:valid_array]) }
        it 'returns the all PRs minus scoring_pull_requests' do
          expect(pr_service.non_scoring_pull_requests.count).to eq(1)
        end
      end

      context 'with with 2 eligible pull requests' do
        before { stub_helper(PR_DATA[:valid_array].first(2)) }
        it 'returns an empty array' do
          expect(pr_service.non_scoring_pull_requests.count).to eq(0)
        end
      end
    end
  end

  describe '#persisted_winning_pull_requests' do
    context 'with a winning or completed user receipt' do
      it 'returns an array of PullRequests from receipt' do
        expect(user_with_receipt.receipt.count)
          .to eq(pr_service_for_user_w_receipt
                  .persisted_winning_pull_requests.count)
      end
    end
  end

  describe '#non_scoring_pull_requests_for_completed_or_won' do
    context 'pull requests from PullRequestService.all exist in user receipt' do
      before do
        allow(pr_service_for_user_w_receipt).to receive(:all)
          .and_return(pull_request_data(PR_DATA[:array_for_receipt_logic]))
      end

      it 'returns a new filtered array from user receipt PRs' do
        expect(pr_service_for_user_w_receipt.all.count)
          .to_not eq(pr_service_for_user_w_receipt
                      .non_scoring_pull_requests_for_completed_or_won.count)
      end

      it 'filters out the 5 PRs in receipt from all 7 PRs' do
        expect(pr_service_for_user_w_receipt
                .non_scoring_pull_requests_for_completed_or_won.count).to eq(2)
      end
    end
  end

  def stub_helper(arr_type)
    allow(pr_service)
      .to receive(:github_pull_requests)
      .and_return(pull_request_data(arr_type))
  end
end
