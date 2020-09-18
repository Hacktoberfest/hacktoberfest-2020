# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPullRequestSegmentUpdaterService do
  describe '.call' do
    context 'the user has an initial set of pull requests' do
      let(:user) { FactoryBot.create(:user) }

      before(:each) do
        PullRequestFilterHelper.pr_stub_helper(
          user,
          PR_DATA[:mature_array][0...3]
        )
      end

      context 'when User#score is touched and the PRs are stored in the DB' do
        it 'gets called once' do
          expect(UserPullRequestSegmentUpdaterService).to receive(:call)
          allow_any_instance_of(SegmentService).to receive(:identify)
          user.score
        end

        it 'calls SegmentService#identify with the correct number of PRs' do
          expect_any_instance_of(SegmentService)
            .to receive(:identify).with(pull_requests_count: 3)
          user.score
        end
      end
    end

    context 'the user has no new pull requests' do
      let(:user) { FactoryBot.create(:user) }

      before(:each) do
        # Add the initial three PRs and ignore that Segment update
        PullRequestFilterHelper.pr_stub_helper(
          user,
          PR_DATA[:mature_array][0...3]
        )
        allow(UserPullRequestSegmentUpdaterService)
          .to receive(:call).and_return(true)
        user.score
        allow(UserPullRequestSegmentUpdaterService)
          .to receive(:call).and_call_original

        # Add no further pull requests
      end

      context 'when User#score is touched and the PRs are stored in the DB' do
        it 'does not get called' do
          expect(UserPullRequestSegmentUpdaterService).not_to receive(:call)
          user.score
        end
      end
    end

    context 'the user gains a new pull request' do
      let(:user) { FactoryBot.create(:user) }

      before(:each) do
        # Add the initial three PRs and ignore that Segment update
        PullRequestFilterHelper.pr_stub_helper(
          user,
          PR_DATA[:mature_array][0...3]
        )
        allow(UserPullRequestSegmentUpdaterService)
          .to receive(:call).and_return(true)
        user.score
        allow(UserPullRequestSegmentUpdaterService)
          .to receive(:call).and_call_original

        # Stub the user with four PRs, keeping the previous three in the DB
        PullRequestFilterHelper.pr_stub_helper(
          user,
          PR_DATA[:mature_array],
          false
        )
      end

      context 'when User#score is touched and the PRs are stored in the DB' do
        it 'gets called once' do
          expect(UserPullRequestSegmentUpdaterService).to receive(:call)
          allow_any_instance_of(SegmentService).to receive(:identify)
          user.score
        end

        it 'calls SegmentService#identify with the correct number of PRs' do
          expect_any_instance_of(SegmentService)
            .to receive(:identify).with(pull_requests_count: 4)
          user.score
        end
      end
    end

    context 'the user gains multiple new pull requests' do
      let(:user) { FactoryBot.create(:user) }

      before(:each) do
        # Add the initial three PRs and ignore that Segment update
        PullRequestFilterHelper.pr_stub_helper(
          user,
          PR_DATA[:large_immature_array][0...3]
        )
        allow(UserPullRequestSegmentUpdaterService)
          .to receive(:call).and_return(true)
        user.score
        allow(UserPullRequestSegmentUpdaterService)
          .to receive(:call).and_call_original

        # Stub the user with all six PRs, keeping the previous three in the DB
        PullRequestFilterHelper.pr_stub_helper(
          user,
          PR_DATA[:large_immature_array],
          false
        )
      end

      context 'when User#score is touched and the PRs are stored in the DB' do
        it 'gets called once' do
          expect(UserPullRequestSegmentUpdaterService).to receive(:call)
          allow_any_instance_of(SegmentService).to receive(:identify)
          user.score
        end

        it 'calls SegmentService#identify with the correct number of PRs' do
          # You might be confused why this is 4, and not 6...
          # We send User#score to Segment, which is capped at 4
          expect_any_instance_of(SegmentService)
            .to receive(:identify).with(pull_requests_count: 4)
          user.score
        end
      end
    end
  end
end
