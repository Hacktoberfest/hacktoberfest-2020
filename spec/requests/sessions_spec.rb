# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  before { mock_authentication }

  describe 'signup and login' do
    it 'logs the user in' do
      login
      expect(session[:current_user_id]).to_not eq(nil)
    end

    context 'user already exists' do
      before do
        User.create(uid: 123_456)
      end

      it 'does not create a new User' do
        expect { login }.to change { User.count }.by(0)
      end
    end

    context 'user does not exist' do
      it 'creates a new user' do
        expect { login }.to change { User.count }.by(1)
      end
    end
  end

  describe 'requesting protected resource' do
    context 'user not logged in' do
      it 'redirects the user to login' do
        get profile_path
        expect(response).to redirect_to(login_path)
      end

      it 'saves user destination in the session' do
        get profile_path
        expect(session[:destination]).to eq(profile_path)
      end
    end

    context 'user is logged in' do
      before do
        login
      end

      it 'the request is succesful' do
        get profile_path
        expect(response).to be_success
      end
    end
  end

  describe 'logout' do
    context 'The user is logged in' do
      before do
        login
      end

      it 'logs the user out' do
        get logout_path
        expect(session[:current_user_id]).to eq(nil)
      end
    end
  end
end
