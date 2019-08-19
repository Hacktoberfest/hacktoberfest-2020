# frozen_string_literal: true

require 'faraday'

class SessionsController < ApplicationController
  def create
    @user = User.where(uid: auth_hash[:uid]).first_or_create
    session[:current_user_id] = @user.id
    getUserToken(params['code'], params['state'])
    redirect_to session[:destination] || '/'
  end

  def get_user_token(code, state)
    conn = Faraday.new(url: 'https://github.com')

    response = conn.post('/login/oauth/access_token', {
                           code: code,
                           client_id: ENV['GITHUB_CLIENT_ID'],
                           client_secret: ENV['GITHUB_CLIENT_SECRET'],
                           state: state
                         })
    binding.pry
  end

  def destroy
    logout
    redirect_to '/'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

  def logout
    session[:current_user_id] = nil
  end
end
