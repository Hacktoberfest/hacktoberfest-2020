# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_current_user
  rescue_from Faraday::ClientError, with: :api_error
  rescue_from Octokit::Unauthorized, with: :github_unauthorized_error

  def current_user
    return unless logged_in?

    if (user = User.find_by(id: session[:current_user_id]))
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
    return if logged_in? && valid_token?

    session[:destination] = request.path
    redirect_to login_path
  end

  def require_user_registered!
    return if logged_in? && !@current_user.new?

    if Hacktoberfest.ended?
      render 'pages/hacktoberfest_ended'
    else
      redirect_to start_path
    end
  end

  def disallow_registered_user!
    return unless logged_in? && !@current_user.new?

    redirect_to profile_path
  end

  private

  def valid_token?
    TokenValidatorService.new(@current_user.provider_token).valid?
  end

  def api_error(error)
    raise error unless error.response&.fetch(:status) == 502

    render 'pages/api_error', status: :internal_server_error
  end

  def github_unauthorized_error
    render 'pages/github_unauthorized_error', status: :unauthorized
  end
end
