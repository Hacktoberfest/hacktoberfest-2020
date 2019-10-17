require "rails_helper"

RSpec.describe 'CVE-2015-9284', type: :request do
  describe 'GET /auth/github' do
    it 'raises a routing error' do
      expect { get login_path }.to raise_error(ActionController::RoutingError)
    end
  end

  describe 'POST /auth/:provider without CSRF token' do
    before do
      @allow_forgery_protection = ActionController::Base.allow_forgery_protection
      ActionController::Base.allow_forgery_protection = true
    end

    it do
      expect {
        post login_path
      }.to raise_error(ActionController::InvalidAuthenticityToken)
    end

    after do
      ActionController::Base.allow_forgery_protection = @allow_forgery_protection
    end
  end
end
