# frozen_string_literal: true

require 'rails_helper'

describe ProfilePagePresenter do
  let(:user) { FactoryBot.create(:user) }
  let(:shirt_winner) { FactoryBot.create(:user, :won_shirt) }
  let(:sticker_winner) { FactoryBot.create(:user, :won_sticker) }
  let(:profile_presenter) { ProfilePagePresenter.new(user) }
  let(:won_shirt_presenter) { ProfilePagePresenter.new(shirt_winner) }
  let(:won_sticker_presenter) { ProfilePagePresenter.new(sticker_winner) }
  let(:incompleted_user_presenter) { ProfilePagePresenter.new(incomplete_user) }

  context 'Hacktoberfest is in pre launch' do
    before do
      allow(Hacktoberfest).to receive(:pre_launch?).and_return(true)
      allow(Hacktoberfest).to receive(:active?).and_return(false)
      allow(Hacktoberfest).to receive(:ended?).and_return(false)
    end

    it 'displays the pre_launch partial' do
      expect(profile_presenter.display_pre_launch?).to eq(true)
    end

    it 'does not display the winners partial' do
      expect(profile_presenter.display_winner?).to eq(false)
    end

    it 'does not display the participants partial' do
      expect(profile_presenter.display_thank_you?).to eq(false)
    end
  end

  context 'Hacktoberfest has ended and the user has won' do
    before do
      allow(Hacktoberfest).to receive(:ended?).and_return(true)
      allow(Hacktoberfest).to receive(:pre_launch?).and_return(false)
      allow(Hacktoberfest).to receive(:active?).and_return(false)
      allow(user).to receive(:won_hacktoberfest?).and_return(true)
    end

    it 'displays the winners partial' do
      expect(profile_presenter.display_winner?).to eq(true)
    end

    it 'does not display participant partial', vcr: { record: :new_episodes } do
      expect(profile_presenter.display_thank_you?).to eq(false)
    end

    it 'does not display the pre_launch partial' do
      expect(profile_presenter.display_pre_launch?).to eq(false)
    end
  end

  context 'the user has won a shirt' do
    it 'displays a shirt coupon' do
      expect(shirt_winner.shirt_coupon).to_not be(nil)
    end

    it 'returns a coupon code for the user' do
      expect(won_shirt_presenter.code).to_not be(nil)
    end
  end

  context 'the user has won a sticker' do
    it 'displays a sticker coupon' do
      expect(sticker_winner.sticker_coupon).to_not be(nil)
    end

    it 'returns a coupon code for the user' do
      expect(won_sticker_presenter.code).to_not be(nil)
    end
  end

  context 'Hacktoberfest has ended the user has not won' do
    let(:incomplete_user) { FactoryBot.create(:user, :incompleted) }
    before do
      allow(Hacktoberfest).to receive(:end_date).and_return(Date.today - 7)
      allow(Hacktoberfest).to receive(:ended?).and_return(true)
      allow(Hacktoberfest).to receive(:pre_launch?).and_return(false)
      allow(Hacktoberfest).to receive(:active?).and_return(false)
      allow(incomplete_user).to receive(:hacktoberfest_ended?).and_return(true)
      allow(incomplete_user).to receive(:won_hacktoberfest?).and_return(false)
    end

    it 'displays the participants partial', vcr: { record: :new_episodes } do
      expect(incompleted_user_presenter.display_thank_you?).to eq(true)
    end

    it 'does not display the results_partial' do
      expect(incompleted_user_presenter.display_winner?).to eq(false)
    end

    it 'does not display the pre_launch partial' do
      expect(incompleted_user_presenter.display_pre_launch?).to eq(false)
    end
  end
end
