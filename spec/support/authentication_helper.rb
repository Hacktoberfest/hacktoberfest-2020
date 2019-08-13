module AuthenticationHelper
  def login(provider='github', uid='123456')
      omniauth_hash = {
        'provider': provider,
        'uid': uid,
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
    get "/auth/github/callback"
  end
end
