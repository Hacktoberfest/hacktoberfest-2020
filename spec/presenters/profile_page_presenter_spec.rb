# frozen_string_literal: true

require 'rails_helper'

describe ProfilePagePresenter do
  let(:user) { FactoryBot.create(:user) }
  let(:waiting_user) { FactoryBot.create(:user, :waiting) }
  let(:incomplete_user) { FactoryBot.create(:user, :incompleted) }
  let(:shirt_winner) { FactoryBot.create(:user, :won_shirt) }
  let(:sticker_winner) { FactoryBot.create(:user, :won_sticker) }
  let(:profile_presenter) { ProfilePagePresenter.new(user) }
  let(:waiting_user_presenter) { ProfilePagePresenter.new(waiting_user) }
  let(:won_shirt_presenter) { ProfilePagePresenter.new(shirt_winner) }
  let(:won_sticker_presenter) { ProfilePagePresenter.new(sticker_winner) }
  let(:incompleted_user_presenter) { ProfilePagePresenter.new(incomplete_user) }

  before do
    allow(UserPullRequestSegmentUpdaterService)
      .to receive(:call).and_return(true)
  end

  context 'Hacktoberfest is in pre launch' do
    before { travel_to Time.zone.parse(ENV['START_DATE']) - 7.days }

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
      expect(waiting_user_presenter.display_waiting_for_prize?).to eq(false)
    end

    after { travel_back }
  end

  context 'Hacktoberfest has ended and the user has won' do
    before { travel_to Time.zone.parse(ENV['END_DATE']) + 8.days }

    it 'displays the coupons partial for a shirt winner' do
      expect(won_shirt_presenter.display_coupon?).to eq(true)
    end

    it 'displays the coupons partial for a sticker winner' do
      expect(won_sticker_presenter.display_coupon?).to eq(true)
    end

    it 'does not display participant partial' do
      expect(profile_presenter.display_thank_you?).to eq(false)
    end

    it 'does not display the pre_launch partial' do
      expect(profile_presenter.display_pre_launch?).to eq(false)
    end

    it 'does not display the display the waiting for prize partial' do
      expect(waiting_user_presenter.display_waiting_for_prize?).to eq(false)
    end

    after { travel_back }
  end

  context 'the user has won a shirt' do
    it 'returns a coupon code for the user' do
      expect(won_shirt_presenter.code).to be_a(String)
    end
  end

  context 'the user has won a sticker' do
    it 'returns a coupon code for the user' do
      expect(won_sticker_presenter.code).to be_a(String)
    end
  end

  context 'Hacktoberfest has ended the user is incomplete' do
    before { travel_to Time.zone.parse(ENV['END_DATE']) + 8.days }

    it 'displays the thank you partial' do
      expect(incompleted_user_presenter.display_thank_you?).to eq(true)
    end

    it 'does not display the coupons partial' do
      expect(incompleted_user_presenter.display_coupon?).to eq(false)
    end

    it 'does not display the waiting for prize partial' do
      expect(waiting_user_presenter.display_waiting_for_prize?).to eq(false)
    end

    it 'does not display the pre_launch partial' do
      expect(incompleted_user_presenter.display_pre_launch?).to eq(false)
    end

    after { travel_back }
  end
end
