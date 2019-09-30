# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_current_user

  def current_user
    return unless logged_in?

    if (user = User.find_by_id(session[:current_user_id]))
      user
    else
      reset_session
      redirect_to root_path
    end
  end

  def logged_in?
    session[:current_user_id].present?
  end

  def set_current_user
    @current_user = current_user
  end

  def require_user_logged_in!
    return if logged_in?

    session[:destination] = request.path
    redirect_to login_path
  end

  def require_user_registered!
    return if logged_in? && !@current_user.new?

    redirect_to start_path
  end

  def disallow_registered_user!
    return unless logged_in? && !@current_user.new?

    redirect_to profile_path
  end
end
