# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TokenValidatorService do
  describe '#valid?' do
    let(:user) { FactoryBot.create(:user) }
    subject { described_class.new(user.provider_token) }

    context 'valid token' do
      it 'returns true', :vcr do
        expect(subject.valid?).to eq(true)
      end
    end

    context 'invalid token', :vcr do
      it 'returns false' do
        expect(subject.valid?).to eq(false)
      end
    end
  end
end
