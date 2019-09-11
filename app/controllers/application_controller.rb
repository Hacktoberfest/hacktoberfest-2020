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

  def require_user_logged_in!
    return if logged_in?

    session[:destination] = request.path
    redirect_to login_path
  end

  def require_user_registration!
    binding.pry
    return if logged_in? && @current_user.terms_acceptance

    session[:destination] = request.path
    if logged_in?
      redirect_to register_form_path
    else
      redirect_to login_path
    end
  end
end
