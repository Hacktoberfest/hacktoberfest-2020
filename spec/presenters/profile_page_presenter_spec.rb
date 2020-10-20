# frozen_string_literal: true

require 'rails_helper'

describe ProfilePagePresenter do
  before do
    allow(UserPullRequestSegmentUpdaterService)
      .to receive(:call).and_return(true)
  end

  context 'Hacktoberfest is in pre launch' do
    before { travel_to Time.zone.parse(ENV['START_DATE']) - 7.days }

    let(:user) { FactoryBot.create(:user) }
    let(:profile_presenter) { ProfilePagePresenter.new(user) }

    it 'displays the pre_launch partial' do
      expect(profile_presenter.display_pre_launch?).to eq(true)
    end

    it 'does not display the coupons partial' do
      expect(profile_presenter.display_coupon?).to eq(false)
    end

    it 'does not display the thank you partial' do
      expect(profile_presenter.display_thank_you?).to eq(false)
    end

    it 'does not display the waiting for prize partial' do
      expect(profile_presenter.display_waiting_for_prize?).to eq(false)
    end

    after { travel_back }
  end

  context 'the user has won a shirt' do
    let(:shirt_winner) { FactoryBot.create(:user, :won_shirt) }
    let(:shirt_presenter) { ProfilePagePresenter.new(shirt_winner) }

    it 'returns a coupon code for the user' do
      expect(shirt_presenter.code).to be_a(String)
    end

    context 'Hacktoberfest has ended' do
      before { travel_to Time.zone.parse(ENV['END_DATE']) + 8.days }

      it 'displays the coupons partial for a shirt winner' do
        expect(shirt_presenter.display_coupon?).to eq(true)
      end

      it 'does not display participant partial' do
        expect(shirt_presenter.display_thank_you?).to eq(false)
      end

      it 'does not display the pre_launch partial' do
        expect(shirt_presenter.display_pre_launch?).to eq(false)
      end

      it 'does not display the display the waiting for prize partial' do
        expect(shirt_presenter.display_waiting_for_prize?).to eq(false)
      end

      after { travel_back }
    end
  end

  context 'the user has won a sticker' do
    let(:sticker_winner) { FactoryBot.create(:user, :won_sticker) }
    let(:sticker_presenter) { ProfilePagePresenter.new(sticker_winner) }

    it 'returns a coupon code for the user' do
      expect(sticker_presenter.code).to be_a(String)
    end

    context 'Hacktoberfest has ended' do
      before { travel_to Time.zone.parse(ENV['END_DATE']) + 8.days }

      it 'displays the coupons partial for a sticker winner' do
        expect(sticker_presenter.display_coupon?).to eq(true)
      end

      it 'does not display participant partial' do
        expect(sticker_presenter.display_thank_you?).to eq(false)
      end

      it 'does not display the pre_launch partial' do
        expect(sticker_presenter.display_pre_launch?).to eq(false)
      end

      it 'does not display the display the waiting for prize partial' do
        expect(sticker_presenter.display_waiting_for_prize?).to eq(false)
      end

      after { travel_back }
    end
  end

  context 'Hacktoberfest has ended the user is incomplete' do
    before { travel_to Time.zone.parse(ENV['END_DATE']) + 8.days }

    let(:incomplete_user) { FactoryBot.create(:user, :incompleted) }
    let(:incomplete_presenter) { ProfilePagePresenter.new(incomplete_user) }

    it 'displays the thank you partial' do
      expect(incomplete_presenter.display_thank_you?).to eq(true)
    end

    it 'does not display the coupons partial' do
      expect(incomplete_presenter.display_coupon?).to eq(false)
    end

    it 'does not display the waiting for prize partial' do
      expect(incomplete_presenter.display_waiting_for_prize?).to eq(false)
    end

    it 'does not display the pre_launch partial' do
      expect(incomplete_presenter.display_pre_launch?).to eq(false)
    end

    after { travel_back }
  end

  context 'the user is waiting' do
    let(:waiting_user) { FactoryBot.create(:user, :waiting) }
    let(:waiting_presenter) { ProfilePagePresenter.new(waiting_user) }

    # Ensure the user is in the right state before we change time
    before { waiting_user.state }

    context 'Hacktoberfest has ended' do
      before { travel_to Time.zone.parse(ENV['END_DATE']) + 8.days }

      it 'displays the waiting thank you partial' do
        expect(waiting_presenter.display_waiting_thank_you?).to eq(true)
      end

      it 'does not display the coupons partial' do
        expect(waiting_presenter.display_coupon?).to eq(false)
      end

      it 'does not display the waiting for prize partial' do
        expect(waiting_presenter.display_waiting_for_prize?).to eq(false)
      end

      it 'does not display the pre_launch partial' do
        expect(waiting_presenter.display_pre_launch?).to eq(false)
      end

      after { travel_back }
    end
  end
end
