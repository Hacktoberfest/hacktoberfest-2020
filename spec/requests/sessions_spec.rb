require "rails_helper"

RSpec.describe 'Sessions', type: :request do

  describe "signup and login" do

    it "logs the user in" do
      login
      expect(session[:current_user_id]).to_not eq(nil)
    end

    context "user already exists" do
      before do
        user = User.create(gh_id: 123456)
      end

      it "does not create a new User" do
        expect { login }.to change { User.count }.by(0)
      end
    end

    context "user does not exist" do
      it "creates a new user" do
        expect { login }.to change { User.count }.by(1)
      end
    end
  end

  describe "logout" do
    context "The user is logged in" do
      before do
        login
      end

      it "logs the user out" do
        get "/logout"
        expect(session[:current_user_id]).to eq(nil)
      end
    end
  end
end
