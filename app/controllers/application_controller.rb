# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_current_user

  def current_user
    return unless logged_in?

    User.find(session[:current_user_id])
  end

  def logged_in?
    session[:current_user_id].present?
  end

  def set_current_user
    @current_user = current_user
  end

  def authenticate_user!
    return if logged_in?

    session[:destination] = request.path
    redirect_to login_path
  end
end
