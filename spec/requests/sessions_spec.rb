require "rails_helper"

RSpec.describe 'Sessions', type: :request do

  describe "signup and login" do
    before do
      omniauth_hash = {
        'provider': 'github',
        'uid': '123456',
        'info': {
          'name': 'Frida',
          'emaill': 'mail@example.com',
          'nickname': 'fridaland'
        },
        'extra': {
          'raw_info': {
            'location': 'New York'
          }
        }
      }
      OmniAuth.config.add_mock(:github, omniauth_hash)
      Rails.application.env_config["omniauth.auth"] =
        OmniAuth.config.mock_auth[:github]
    end

    it "logs the user in" do

      get "/auth/github/callback"
      expect(session[:current_user_id]).to_not eq(nil)
    end

    context "user already exists" do
      before do
        user = User.create(gh_id: 123456)
      end

      it "does not create a new User" do
        expect { get "/auth/github/callback" }.to change { User.count }.by(0)
      end
    end

    context "user does not exist" do
      it "creates a new user" do
        expect { get "/auth/github/callback" }.to change { User.count }.by(1)
      end
    end
  end

  describe "logout" do
    context "The user is logged in" do
      # before { login_as(User.first) }
      #the user has to be logged in before we log them out

      it "logs the user out" do

        get "/logout"
        expect(session[:current_user_id]).to eq(nil)
      end
    end
  end
end
