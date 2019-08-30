# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#register' do
    before { user.register }
    context 'user is created but has not agreed to terms' do
      let(:user) { FactoryBot.create(:user, :unregistered) }

      it 'disallows the user to enter the registered state' do
        expect(user.register).to eq(false)
      end
      it 'applies the correct errors to the user object' do
        user.register
        expect(user.errors.messages[:terms_acceptance][0])
          .to eq('must be accepted')
      end
    end

    context 'user is created but has no email' do
      let(:user) { FactoryBot.create(:user, :unregistered, :no_email) }

      it 'disallows the user to enter the registered state' do
        expect(user.register).to eq(false)
      end

      it 'applies the correct errors to the user object' do
        user.register
        expect(user.errors.messages[:email][0]).to eq("can't be blank")
      end
    end

    context 'user is created but has neither an email nor an agreement' do
      let(:user) { FactoryBot.create(:user, :unregistered, :no_email) }

      it 'disallows the user to enter the registered state' do
        expect(user.register).to eq(false)
      end

      it 'applies errors to the user' do
        user.register
        expect(user.errors.messages[:email][0]).to eq("can't be blank")
        expect(user.errors.messages[:terms_acceptance][0])
          .to eq('must be accepted')
      end
    end

    context 'an unregistered user has an email and has agreed to terms' do
      let(:user) { FactoryBot.create(:user, :unregistered) }

      before { user.terms_acceptance = true }

      it 'allows the user to enter the registered state' do
        expect(user.register).to eq(true)
      end

      it 'persists the registered state' do
        user.register
        user.reload
        expect(user.state).to eq('registered')
      end
    end
  end
end
