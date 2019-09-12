# frozen_string_literal: true

module AuthenticationHelper
  def login
    get '/auth/github/callback'
  end

  def mock_authentication(provider: 'github', uid: '123_456')
    omniauth_hash = {
      'provider': provider,
      'uid': uid,
      'credentials': {
        'token': user_github_token,
        'expires': 'false'
      },
      'info': {
        'name': 'Frida',
        'email': 'mail@example.com',
        'nickname': 'fridaland'
      },
      'extra': {
        'raw_info': {
          'location': 'New York'
        }
      }
    }
    OmniAuth.config.add_mock(:github, omniauth_hash)
    Rails.application.env_config['omniauth.auth'] =
      OmniAuth.config.mock_auth[:github]
  end

  # This method is needed in order to set expectations on the current user
  # It mocks the @current_user variable with the same user instance that is
  # passed. This skips the oauth authentication flow and should not be used
  # with the `login` and/or `mock_authentication` method.
  def mock_current_user(user)
    ApplicationController.class_eval do
      def self.setting_current_user(user)
        define_method :current_user do
          user
        end
      end

      def logged_in?
        true
      end
    end

    ApplicationController.setting_current_user(user)
  end
end
