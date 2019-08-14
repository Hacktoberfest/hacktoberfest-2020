# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def current_user
    user = User.find(session[:current_user_id])
    @current_user ||= user if session[:current_user_id]
  end

  def logged_in?
    !@current_user.nil?
  end
end
