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

  describe '#wait' do
    context 'user has 4 open prs' do
      let(:user) { FactoryBot.create(:user) } 

      before do
        user.register
        user.stub(:score) { 4 }
      end

      it 'allows the user to enter the waiting state' do
        expect(user.wait).to eq(true)
      end

      it 'persists the waiting state' do
        user.wait
        user.reload
        expect(user.state).to eq('waiting')
      end
    end

    context 'user has less than 4 open prs' do 
      let(:user) { FactoryBot.create(:user) } 

      before do
        user.register
        user.stub(:score) { 3 }
      end

      it 'disallows the user to enter the waiting state' do
        expect(user.wait).to eq(false)
      end

      it 'keeps the user in the registered state' do 
        expect(user.state).to eq('registered')
      end
    end

    context 'hacktoberfest has ended' do
      let(:user) { FactoryBot.create(:user) } 

      before do
        user.register
        user.stub(:score) { 3 }
        user.stub(:hacktoberfest_ended?) { true }
      end

      it 'moves user to waiting regardless of pr count' do
        expect(user.wait).to eq(true)
      end

      it 'persists the waiting state' do
        user.wait
        user.reload
        expect(user.state).to eq('waiting')
      end
    end
  end

  describe '#complete' do
    context 'the user has 4 mature PRs' do 
      let(:user) { FactoryBot.create(:user) }

      before {
        user.register
        user.stub(:score) { 4 }
        user.wait
        user.stub(:score_mature_prs) { 4 }
      }

      it 'allows the user to enter the completed state' do
        expect(user.complete).to eq(true)
      end

      it 'persists the completed state' do
        user.complete
        user.reload
        expect(user.state).to eq('completed')
      end
    end

    context 'the user does not have 4 mature PRs' do 
      let(:user) { FactoryBot.create(:user) }

      before {
        user.register
        user.stub(:score) { 4 }
        user.wait
        user.stub(:score_mature_prs) { 3 }
      }

      it 'disallows the user to enter the completed state' do
        expect(user.complete).to eq(false)
      end
    end
  end
end
