# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, type: :request do
  before do
    mock_authentication
    allow_any_instance_of(SegmentService).to receive(:identify)
    allow_any_instance_of(SegmentService).to receive(:track)
  end

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
      it 'redirects the user to login', vcr: { record: :new_episodes } do
        get profile_path
        expect(response).to redirect_to(login_path)
      end

      it 'saves user destination in session', vcr: { record: :new_episodes } do
        get profile_path
        expect(session[:destination]).to eq(profile_path)
      end
    end

    context 'user is logged in and registered' do
      let(:registered_user) { FactoryBot.create(:user) }
      before do
        mock_authentication(uid: registered_user.uid)
        login
      end

      it 'the request is succesful', vcr: { record: :new_episodes } do
        get profile_path
        expect(response).to be_successful
      end
    end

    context 'user is logged in and the user is not registered' do
      let(:user) { FactoryBot.create(:user, :new) }
      before do
        login
        mock_authentication(uid: user.uid)
      end

      it 'the request is unsuccesful', vcr: { record: :new_episodes } do
        get profile_path
        expect(response).to_not be_successful
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

  describe 'impersionation' do
    let(:user) { FactoryBot.create(:user) }

    context 'the app is in production mode' do
      before { allow(Rails).to receive(:env) { "production".inquiry } }

      it 'returns a 404' do
        expect{ get impersonate_path(user) }.
          to raise_error(ActionController::RoutingError)
      end
    end

    context 'the app is in development mode' do
      before { allow(Rails).to receive(:env) { "development".inquiry } }

      it 'impersonates the user' do
        get impersonate_path(user)
        expect(session[:current_user_id]).to eq(user.id)
      end

      context 'the user does not exist' do
        let(:user) { FactoryBot.build(:user) }

        it 'does nothing' do
          get '/impersonate/0'
          expect(session[:current_user_id]).to eq(nil)
        end
      end
    end
  end
end
