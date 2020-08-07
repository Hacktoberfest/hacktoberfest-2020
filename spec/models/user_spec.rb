# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    allow(UserPullRequestSegmentUpdaterService)
      .to receive(:call).and_return(true)
  end

  describe '#register' do
    context 'user is created but has not agreed to terms' do
      let(:user) { FactoryBot.create(:user, :new) }

      before do
        expect(UserStateTransitionSegmentService).to_not receive(:call)

        user.register
      end

      it 'disallows the user to enter the registered state' do
        expect(user.state).to eq('new')
      end

      it 'applies the correct errors to the user object' do
        expect(user.errors.messages[:terms_acceptance].first)
          .to eq('must be accepted')
      end
    end

    context 'user has no email' do
      let(:user) { FactoryBot.create(:user, :no_email, state: 'new') }

      before do
        expect(UserStateTransitionSegmentService).to_not receive(:call)

        user.register
      end

      it 'disallows the user to enter the registered state' do
        expect(user.state).to eq('new')
      end

      it 'applies the correct errors to the user object' do
        expect(user.errors.messages[:email].first).to eq("can't be blank")
      end
    end

    context 'user has neither an email nor an agreement' do
      let(:user) { FactoryBot.create(:user, :new, :no_email) }

      before do
        expect(UserStateTransitionSegmentService).to_not receive(:call)

        user.register
      end

      it 'disallows the user to enter the registered state' do
        expect(user.state).to eq('new')
      end

      it 'adds the correct errors to the user object' do
        expect(user.errors.messages[:email].first).to eq("can't be blank")
        expect(user.errors.messages[:terms_acceptance].first)
          .to eq('must be accepted')
      end
    end

    context 'an unregistered user has an email and has agreed to terms' do
      let(:user) { FactoryBot.create(:user, state: 'new') }

      before do
        expect(UserStateTransitionSegmentService)
          .to receive(:register).and_return(true)

        user.register
      end

      it 'allows the user to enter the registered state' do
        expect(user.state).to eq('registered')
      end

      it 'persists the registered state' do
        user.reload
        expect(user.state).to eq('registered')
      end
    end
  end

  describe '#wait' do
    context 'registered user has 4 open prs' do
      let(:user) { FactoryBot.create(:user) }

      before do
        pr_stub_helper(user, PR_DATA[:immature_array])
        expect(UserStateTransitionSegmentService)
          .to receive(:wait).and_return(true)

        user.wait
      end

      it 'allows the user to enter the waiting state' do
        expect(user.state).to eq('waiting')
      end

      # it 'updates the waiting_since correctly' do
      #   prs = pull_request_data(PR_DATA[:mature_array]).map do |pr|
      #     PullRequest.from_github_pull_request(pr)
      #   end
      #
      #   latest_pr = prs.max_by do |pr|
      #     pr.github_pull_request.created_at
      #   end
      #
      #   expect(user.waiting_since)
      #     .to eq(Time.zone.parse(latest_pr.github_pull_request.created_at))
      # end

      it 'persists the waiting state' do
        user.reload
        expect(user.state).to eq('waiting')
      end
    end

    context 'registered user has less than 4 open prs' do
      let(:user) { FactoryBot.create(:user) }

      before do
        pr_stub_helper(user, PR_DATA[:immature_array][0...3])
        expect(UserStateTransitionSegmentService).to_not receive(:call)

        user.wait
      end

      it 'disallows the user to enter the waiting state' do
        expect(user.state).to eq('registered')
      end

      it 'adds the correct errors to the user' do
        expect(user.errors.messages[:state].first)
          .to include('cannot transition via "wait"')
      end
    end
  end

  describe '#complete' do
    let(:user) { FactoryBot.create(:user, :waiting) }

    context 'the user has 4 eligible PRs and has been waiting for 7 days' do
      before do
        pr_stub_helper(user, PR_DATA[:mature_array])
        expect(UserStateTransitionSegmentService)
          .to receive(:complete).and_return(true)

        user.complete
      end

      it 'allows the user to enter the completed state' do
        expect(user.state).to eq('completed')
      end

      it 'persists the completed state' do
        user.reload
        expect(user.state).to eq('completed')
      end

      it 'persists a receipt of the scoring prs' do
        user.reload
        expect(user.receipt)
          .to eq(JSON.parse(user.scoring_pull_requests_receipt.to_json))
      end
    end

    context 'user has 4 eligible PRs, has been waiting 7 days - no receipt' do
      before do
        pr_stub_helper(user, PR_DATA[:mature_array])
        allow(user).to receive(:receipt).and_return(nil)

        user.complete
      end

      it 'disallows the user to enter the completed state' do
        expect(user.state).to eq('waiting')
      end

      it 'adds the correct errors to user' do
        expect(user.errors.messages[:receipt].first)
          .to include("can't be blank")
      end
    end

    context 'the user has 4 eligible PRs but has not been waiting for 7 days' do
      before do
        pr_stub_helper(user, PR_DATA[:immature_array])
        expect(UserStateTransitionSegmentService).to_not receive(:call)

        user.complete
      end

      it 'disallows the user to enter the completed state' do
        expect(user.state).to eq('waiting')
      end

      it 'adds the correct errors to user' do
        expect(user.errors.messages[:state].first)
          .to include('cannot transition via "complete"')
      end
    end

    context 'the user neither 4 eligible PRs nor has been waiting for 7 days' do
      before do
        pr_stub_helper(user, PR_DATA[:immature_array][0...3])
        expect(UserStateTransitionSegmentService).to_not receive(:call)

        user.complete
      end

      it 'disallows the user to enter the completed state' do
        expect(user.state).to eq('waiting')
      end

      it 'adds the correct errors to user' do
        expect(user.errors.messages[:state].first)
          .to include('cannot transition via "complete"')
      end
    end
  end

  describe '#insufficient' do
    context 'waiting user has dropped below 4 prs' do
      let(:user) { FactoryBot.create(:user, :waiting) }

      before do
        pr_stub_helper(user, PR_DATA[:immature_array][0...3])
        expect(UserStateTransitionSegmentService)
          .to receive(:insufficient).and_return(true)

        user.insufficient
      end

      it 'transitions the user back to the registered state' do
        expect(user.state).to eq('registered')
      end

      it 'persists the registered state' do
        user.reload
        expect(user.state).to eq('registered')
      end
    end
  end

  describe '#retry_complete' do
    before { travel_to Time.zone.parse(ENV['END_DATE']) + 1.day }
    let(:user) { FactoryBot.create(:user, :incompleted) }

    context 'the user has 4 eligible PRs and has been waiting for 7 days' do
      before do
        pr_stub_helper(user, PR_DATA[:mature_array])
        expect(UserStateTransitionSegmentService)
          .to receive(:complete).and_return(true)

        user.retry_complete
      end

      it 'allows the user to enter the completed state' do
        expect(user.state).to eq('completed')
      end

      it 'persists the completed state' do
        user.reload
        expect(user.state).to eq('completed')
      end

      it 'persists a receipt of the scoring prs' do
        user.reload
        expect(user.receipt)
          .to eq(JSON.parse(user.scoring_pull_requests_receipt.to_json))
      end
    end

    context 'user has 4 eligible PRs, has been waiting 7 days - no receipt' do
      before do
        pr_stub_helper(user, PR_DATA[:mature_array])
        allow(user).to receive(:receipt).and_return(nil)

        user.retry_complete
      end

      it 'disallows the user to enter the completed state' do
        expect(user.state).to eq('incompleted')
      end

      it 'adds the correct errors to user' do
        expect(user.errors.messages[:receipt].first)
          .to include("can't be blank")
      end
    end

    context 'the user has 4 waiting PRs but has not been waiting for 7 days' do
      before do
        pr_stub_helper(user, PR_DATA[:late_array])
        expect(UserStateTransitionSegmentService).to_not receive(:call)

        user.retry_complete
      end

      it 'disallows the user to enter the completed state' do
        expect(user.state).to eq('incompleted')
      end

      it 'adds the correct errors to user' do
        expect(user.errors.messages[:sufficient_eligible_prs?].first)
          .to include('user does not have sufficient eligible prs')
      end
    end

    context 'user has been waiting for 7 days & has less than 4 eligible prs' do
      before do
        pr_stub_helper(user, PR_DATA[:mature_array][0...3])
        expect(UserStateTransitionSegmentService).to_not receive(:call)

        user.retry_complete
      end

      it 'disallows the user to enter the completed state' do
        expect(user.state).to eq('incompleted')
      end

      it 'adds the correct errors to user' do
        expect(user.errors.messages[:sufficient_eligible_prs?].first)
          .to include('user does not have sufficient eligible prs')
      end
    end

    context 'the user neither 4 waiting PRs nor has been waiting for 7 days' do
      before do
        pr_stub_helper(user, PR_DATA[:late_array][0...3])
        expect(UserStateTransitionSegmentService).to_not receive(:call)

        user.retry_complete
      end

      it 'disallows the user to enter the completed state' do
        expect(user.state).to eq('incompleted')
      end

      it 'adds the correct errors to user' do
        expect(user.errors.messages[:sufficient_eligible_prs?].first)
          .to include('user does not have sufficient eligible prs')
      end
    end

    after { travel_back }
  end

  describe '#incomplete' do
    context 'the user is in the complete state' do
      let(:user) { FactoryBot.create(:user, :completed) }

      before do
        pr_stub_helper(user, [])
        expect(UserStateTransitionSegmentService).to_not receive(:call)
        user.incomplete
      end

      it 'disallows the user to enter the incomplete state' do
        expect(user.state).to eq('completed')
      end

      it 'adds the correct errors to the user' do
        expect(user.errors.messages[:state].first)
          .to include('cannot transition via "incomplete"')
      end
    end

    context 'hacktoberfest has not yet ended' do
      let(:user) { FactoryBot.create(:user) }

      before do
        pr_stub_helper(user, [])
        expect(UserStateTransitionSegmentService).to_not receive(:call)
        user.incomplete
      end

      it 'disallows the user to enter the incompleted state' do
        expect(user.state).to eq('registered')
      end

      it 'adds the correct errors to the user' do
        expect(user.errors.messages[:hacktoberfest_ended?].first)
          .to include('hacktoberfest has not yet ended')
      end
    end

    context 'hacktoberfest has ended' do
      before { travel_to Time.zone.parse(ENV['END_DATE']) + 8.days }

      context 'user has insufficient eligible prs' do
        let(:user) { FactoryBot.create(:user) }

        before do
          pr_stub_helper(user, PR_DATA[:mature_array][0...3])
          expect(UserStateTransitionSegmentService)
            .to receive(:incomplete).and_return(true)
          user.incomplete
        end

        it 'transitions the user to the incomplete state' do
          expect(user.state).to eq('incompleted')
        end

        it 'persists the incompleted state' do
          user.reload
          expect(user.state).to eq('incompleted')
        end

        it 'persists a receipt of the scoring prs' do
          user.reload
          expect(user.receipt)
            .to eq(JSON.parse(user.scoring_pull_requests_receipt.to_json))
        end
      end

      context 'user has insufficient eligible prs but no receipt' do
        let(:user) { FactoryBot.create(:user, :waiting) }

        before do
          pr_stub_helper(user, PR_DATA[:mature_array][0...3])
          allow(user).to receive(:receipt).and_return(nil)
          user.incomplete
        end

        it 'does not transition the user to the incomplete state' do
          expect(user.state).to eq('waiting')
        end

        it 'persists the waiting state' do
          user.reload
          expect(user.state).to eq('waiting')
        end
      end

      context 'user has too many eligible prs' do
        let(:user) { FactoryBot.create(:user, :waiting) }

        before do
          pr_stub_helper(user, PR_DATA[:mature_array])
          user.incomplete
        end

        it 'does not transition the user to the incomplete state' do
          expect(user.state).to eq('waiting')
        end

        it 'persists the waiting state' do
          user.reload
          expect(user.state).to eq('waiting')
        end
      end

      after { travel_back }
    end
  end

  describe '#gift' do
    before do
      allow(UserStateTransitionSegmentService)
        .to receive(:gifted).and_return(true)
    end

    context 'the user is in the incompleted state' do
      before { travel_to Time.zone.parse(ENV['END_DATE']) + 8.days }
      let(:user) { FactoryBot.create(:user, :incompleted) }

      context 'there are shirt coupons available' do
        before do
          FactoryBot.create(:shirt_coupon)
        end

        # TODO: Edit this spec to allow ability for an incomplete user to
        # receive a gifted shirt and therefore entering gifted_shirt state.
        it 'does not transition user to gifted_shirt state' do
          expect(user.state).to_not eq('gifted_shirt')
        end
      end

      context 'there are sticker coupons available' do
        before do
          FactoryBot.create(:sticker_coupon)
        end

        it 'transitions the user to gifted_sticker state' do
          user.gift
          expect(user.state).to eq('gifted_sticker')
        end
      end

      context 'there are no shirt coupons or sticker coupons available' do
        it 'does not transition the user' do
          user.gift
          expect(user.state).to eq('incompleted')
        end
      end

      after { travel_back }
    end
  end

  describe '#win' do
    before do
      allow(UserStateTransitionSegmentService)
        .to receive(:won).and_return(true)
    end

    context 'the user is in the completed state' do
      let(:user) { FactoryBot.create(:user, :completed) }

      context 'shirt and sticker coupons available' do
        before do
          FactoryBot.create(:shirt_coupon)
          FactoryBot.create(:sticker_coupon)
        end

        it 'transitions the user to the won_shirt state' do
          user.win
          expect(user.state).to eq('won_shirt')
        end
      end

      context 'sticker coupon available' do
        before do
          FactoryBot.create(:sticker_coupon)
        end

        it 'transitions the user to the won_sticker state' do
          user.win
          expect(user.state).to eq('won_sticker')
        end
      end

      context 'no coupons available' do
        it 'does not transition the user' do
          user.win
          expect(user.state).to eq('completed')
        end
      end
    end
  end
end
