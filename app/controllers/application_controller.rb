# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_current_user

  def current_user
    return unless logged_in?

    User.find(session[:current_user_id])
  end

  def logged_in?
    !session[:current_user_id].nil?
  end

  def set_current_user
    @current_user = current_user
  end

  def authenticate_user!
    return unless logged_in?

    session[:destination] = request.env['REQUEST_PATH']
    redirect_to login_path
  end
end
