# frozen_string_literal: true

require 'faraday'

class SessionsController < ApplicationController
  def create
    @user = User.where(uid: auth_hash[:uid]).first_or_create
    session[:current_user_id] = @user.id
    store_user_info
    unless @user.terms_acceptance
     redirect_to register_form_path
    else
     redirect_to session[:destination] || '/'
    end
  end

  def store_user_info
    @user.update(provider_token: auth_hash.credentials.token,
                 name: auth_hash.info.nickname)
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
