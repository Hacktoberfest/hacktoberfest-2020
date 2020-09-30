# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserStateTransitionSegmentService do
  let(:transition) { double }

  before do
    allow(UserPullRequestSegmentUpdaterService)
      .to receive(:call).and_return(true)
  end

  describe '.call' do
    context 'the transition event is register and the user is new' do
      let(:user) { FactoryBot.create(:user, :new) }

      before do
        allow(transition).to receive(:event).and_return(:register)
      end

      it 'calls SegmentService#identify with proper arguments' do
        expect_any_instance_of(SegmentService).to receive(:identify).with(
          email: user.email,
          digitalocean_marketing_emails: user.digitalocean_marketing_emails,
          intel_marketing_emails: user.intel_marketing_emails,
          dev_marketing_emails: user.dev_marketing_emails,
          category: user.category,
          country: user.country,
          state: 'register',
          pull_requests_count: 0
        )
        allow_any_instance_of(SegmentService).to receive(:track).with(
          'register'
        )
        UserStateTransitionSegmentService.call(user, transition)
      end

      it 'calls SegmentService#track with proper arguments' do
        allow_any_instance_of(SegmentService).to receive(:identify).with(
          email: user.email,
          digitalocean_marketing_emails: user.digitalocean_marketing_emails,
          intel_marketing_emails: user.intel_marketing_emails,
          dev_marketing_emails: user.dev_marketing_emails,
          category: user.category,
          country: user.country,
          state: 'register',
          pull_requests_count: 0
        )
        expect_any_instance_of(SegmentService).to receive(:track).with(
          'register'
        )
        UserStateTransitionSegmentService.call(user, transition)
      end
    end

    context 'the transition event is complete and the user is waiting' do
      let(:user) { FactoryBot.create(:user, :waiting) }

      before do
        allow(transition).to receive(:event).and_return(:complete)
      end

      it 'calls SegmentService#identify with proper arguments' do
        allow_any_instance_of(SegmentService).to receive(:track).with(
          'user_completed'
        )
        expect_any_instance_of(SegmentService).to receive(:identify).with(
          state: 'completed'
        )
        UserStateTransitionSegmentService.call(user, transition)
      end

      it 'calls SegmentService#track with proper arguments' do
        allow_any_instance_of(SegmentService).to receive(:identify).with(
          state: 'completed'
        )
        expect_any_instance_of(SegmentService).to receive(:track).with(
          'user_completed'
        )
        UserStateTransitionSegmentService.call(user, transition)
      end
    end

    context 'the event is retry_complete and the user is incompleted' do
      before do
        travel_to Time.zone.parse(ENV['END_DATE']) + 1.day
        allow(transition).to receive(:event).and_return(:retry_complete)
      end

      let(:user) { FactoryBot.create(:user, :incompleted) }

      it 'calls SegmentService#identify with proper arguments' do
        allow_any_instance_of(SegmentService).to receive(:track).with(
          'user_completed'
        )
        expect_any_instance_of(SegmentService).to receive(:identify).with(
          state: 'completed'
        )
        UserStateTransitionSegmentService.call(user, transition)
      end

      it 'calls SegmentService#track with proper arguments' do
        allow_any_instance_of(SegmentService).to receive(:identify).with(
          state: 'completed'
        )
        expect_any_instance_of(SegmentService).to receive(:track).with(
          'user_completed'
        )
        UserStateTransitionSegmentService.call(user, transition)
      end

      after { travel_back }
    end

    context 'the transition event is insufficient and the user is waiting' do
      let(:user) { FactoryBot.create(:user, :waiting) }

      before do
        allow(transition).to receive(:event).and_return(:insufficient)
      end

      it 'calls SegmentService#identify with proper arguments' do
        allow_any_instance_of(SegmentService).to receive(:track).with(
          'user_insufficient'
        )
        expect_any_instance_of(SegmentService).to receive(:identify).with(
          state: 'insufficient'
        )
        UserStateTransitionSegmentService.call(user, transition)
      end

      it 'calls SegmentService#track with proper arguments' do
        allow_any_instance_of(SegmentService).to receive(:identify).with(
          state: 'insufficient'
        )
        expect_any_instance_of(SegmentService).to receive(:track).with(
          'user_insufficient'
        )
        UserStateTransitionSegmentService.call(user, transition)
      end
    end

    context 'the transition event is won and the user is completed' do
      let(:user) { FactoryBot.create(:user, :completed) }

      before do
        allow(transition).to receive(:event).and_return(:won)
      end

      context 'the user won a shirt' do
        let(:coupon) { FactoryBot.create(:shirt_coupon) }

        before do
          allow(transition).to receive(:to).and_return('won_shirt')
        end

        it 'calls SegmentService#identify with proper arguments' do
          expect_any_instance_of(SegmentService).to receive(:identify).with(
            state: 'won_shirt'
          )
          expect_any_instance_of(SegmentService).to receive(:track).with(
            'user_won_shirt'
          )
          UserStateTransitionSegmentService.call(user, transition)
        end

        it 'calls SegmentService#track with proper arguments' do
          expect_any_instance_of(SegmentService).to receive(:identify).with(
            state: 'won_shirt'
          )
          expect_any_instance_of(SegmentService).to receive(:track).with(
            'user_won_shirt'
          )
          UserStateTransitionSegmentService.call(user, transition)
        end
      end

      context 'the user won a sticker' do
        let(:coupon) { FactoryBot.create(:sticker_coupon) }

        before do
          allow(transition).to receive(:to).and_return('won_sticker')
        end

        it 'calls SegmentService#identify with proper arguments' do
          expect_any_instance_of(SegmentService).to receive(:identify).with(
            state: 'won_sticker'
          )
          expect_any_instance_of(SegmentService).to receive(:track).with(
            'user_won_sticker'
          )
          UserStateTransitionSegmentService.call(user, transition)
        end

        it 'calls SegmentService#track with proper arguments' do
          expect_any_instance_of(SegmentService).to receive(:identify).with(
            state: 'won_sticker'
          )
          expect_any_instance_of(SegmentService).to receive(:track).with(
            'user_won_sticker'
          )
          UserStateTransitionSegmentService.call(user, transition)
        end
      end
    end

    context 'the event is gifted and the user is incompleted' do
      before do
        travel_to Time.zone.parse(ENV['END_DATE']) + 1.day
        allow(transition).to receive(:event).and_return(:gifted)
      end

      let(:user) { FactoryBot.create(:user, :incompleted) }

      it 'calls SegmentService#identify with proper arguments' do
        expect_any_instance_of(SegmentService).to receive(:identify).with(
          state: 'gifted_sticker'
        )
        expect_any_instance_of(SegmentService).to receive(:track).with(
          'user_gifted_sticker'
        )
        UserStateTransitionSegmentService.call(user, transition)
      end

      it 'calls SegmentService#track with proper arguments' do
        expect_any_instance_of(SegmentService).to receive(:identify).with(
          state: 'gifted_sticker'
        )
        expect_any_instance_of(SegmentService).to receive(:track).with(
          'user_gifted_sticker'
        )
        UserStateTransitionSegmentService.call(user, transition)
      end

      after { travel_back }
    end
  end
end
