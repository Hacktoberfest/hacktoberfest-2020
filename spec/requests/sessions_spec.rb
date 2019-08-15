# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
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
      it 'does not render the view' do
        get logout_path
        get profile_path
        expect(request.env['path']).to_not eq(profile_path) # modify expect arg
      end

      it 'logs the user in' do
        login
        expect(session[:current_user_id]).to_not eq(nil)
      end

      it 'redirects the user to destination' do
        get profile_path
        expect(request.path).to eq(profile_path)
      end
    end

    context 'user is logged in' do
      before do
        login
      end

      it 'renders thew view' do
        get profile_path
        expect(session[:current_user_id]).to_not eq(nil)
        expect(request.path).to eq(profile_path)
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
