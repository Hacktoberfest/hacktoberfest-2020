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

    it 'does not display the profile timeline partial' do
      expect(profile_presenter.display_timeline?).to eq(false)
    end

    it 'does not display the results_partial' do
      expect(profile_presenter.display_results?).to eq(false)
    end
  end

  context 'Hacktoberfest has ended and the user has won' do
    before do
      allow(Hacktoberfest).to receive(:ended?).and_return(true)
      allow(Hacktoberfest).to receive(:pre_launch?).and_return(false)
      allow(Hacktoberfest).to receive(:active?).and_return(false)
      allow(user).to receive(:won_hacktoberfest?).and_return(true)
    end
    it 'displays the results_partial' do
      expect(profile_presenter.display_results?).to eq(true)
    end

    it 'does not display the pre_launch partial' do
      expect(profile_presenter.display_pre_launch?).to eq(false)
    end

    it 'does not display the timeline_partial' do
      expect(profile_presenter.display_timeline?).to eq(false)
    end
  end

  context 'Hacktoberfest has ended and the user has not won' do
    before do
      allow(Hacktoberfest).to receive(:ended?).and_return(true)
      allow(Hacktoberfest).to receive(:pre_launch?).and_return(false)
      allow(Hacktoberfest).to receive(:active?).and_return(false)
      allow(user).to receive(:won_hacktoberfest?).and_return(false)
    end

    it 'displays the profile timeline partial' do
      expect(profile_presenter.display_timeline?).to eq(true)
    end

    it 'does not display the results_partial' do
      expect(profile_presenter.display_results?).to eq(false)
    end
  end
end
