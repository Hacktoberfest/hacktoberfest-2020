# frozen_string_literal: true

require 'rails_helper'

describe ProfilePagePresenter do
  let(:user) { FactoryBot.create(:user) }
  let(:profile_presenter) { ProfilePagePresenter.new(user) }

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
      expect(profile_presenter.display_winners?).to eq(false)
    end

    it 'does not display the participants partial' do
      expect(profile_presenter.display_participants?).to eq(false)
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
      expect(profile_presenter.display_winners?).to eq(true)
    end

    it 'does not display the participants partial' do
      expect(profile_presenter.display_participants?).to eq(false)
    end

    it 'does not display the pre_launch partial' do
      expect(profile_presenter.display_pre_launch?).to eq(false)
    end
  end

  context 'the user has won a shirt' do
    before do
      let(:shirt_winner) { FactoryBot.create(:user, :won_shirt) }
    end

    it 'assigns the user a shirt coupon' do
      binding.pry
      expect(shirt_winner.shirt_coupon).to exist
    end

    it 'returns a coupon code for the user' do
      expect(profile_presenter.show_coupon).to_not be(nil)
    end
  end

  context 'the user has won a sticker' do
    before do
      let(:sticker_winner) { FactoryBot.create(:user, :won_sticker) }
    end

    it 'assigns the user a sticker coupon' do
      binding.pry
      expect(sticker_winner.sticker_coupon).to exist
    end

    it 'returns a coupon code for the user' do
      expect(profile_presenter.show_coupon).to_not be(nil)
    end
  end

  context 'Hacktoberfest has ended and the user has not won' do
    before do
      allow(Hacktoberfest).to receive(:ended?).and_return(true)
      allow(Hacktoberfest).to receive(:pre_launch?).and_return(false)
      allow(Hacktoberfest).to receive(:active?).and_return(false)
      allow(user).to receive(:won_hacktoberfest?).and_return(false)
    end

    it 'displays the participants partial' do
      expect(profile_presenter.display_participants?).to eq(true)
    end

    it 'does not display the results_partial' do
      expect(profile_presenter.display_winners?).to eq(false)
    end

    it 'does not display the pre_launch partial' do
      expect(profile_presenter.display_pre_launch?).to eq(false)
    end
  end
end
