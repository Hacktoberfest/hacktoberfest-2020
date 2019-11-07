# frozen_string_literal: true

require 'rails_helper'

# These are regression specs to make sure that CVE 2015 9284 stays fixed.
# If these specs begin to fail, it means the vulnerability is exploitable again.
# For more info see:
#   Original issue: https://github.com/omniauth/omniauth/pull/809
#   Solution: https://github.com/omniauth/omniauth/wiki/Resolving-CVE-2015-9284
#   Our PR addressing this: https://github.com/raise-dev/hacktoberfest/pull/351
RSpec.describe 'CVE-2015-9284', type: :request do
  describe 'GET /auth/github' do
    it 'raises a routing error' do
      expect { get '/auth/github' }
        .to raise_error(ActionController::RoutingError)
    end
  end

  describe 'POST /auth/:provider without CSRF token' do
    before do
      @forgery_protection = ActionController::Base.allow_forgery_protection
      ActionController::Base.allow_forgery_protection = true
    end

    it 'raises an error' do
      expect { post '/auth/github' }
        .to raise_error(ActionController::InvalidAuthenticityToken)
    end

    after do
      ActionController::Base.allow_forgery_protection = @forgery_protection
    end
  end
end
