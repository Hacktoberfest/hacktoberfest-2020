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
        'token': ENV.fetch("GITHUB_ACCESS_TOKEN") { "r" * 20 },
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
end
