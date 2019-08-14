# frozen_string_literal: true


class SessionsController < ApplicationController
  def create
    @user = User.where(uid: auth_hash[:uid]).first_or_create
    session[:current_user_id] = @user.id
    redirect_to '/'
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
