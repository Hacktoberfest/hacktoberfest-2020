# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    # This page makes a POST request to /auth/github
    # The POST request has a CSRF token which solves CVE-2015-9284
    # See https://github.com/raise-dev/hacktoberfest/pull/351
    render 'sessions/new'
  end

  def create
    @user = User.where(uid: auth_hash[:uid]).first_or_create
    session[:current_user_id] = @user.id
    store_user_info
    store_segment_user
    redirect_to session[:destination] || '/profile'
  end

  def store_segment_user
    segment = SegmentService.new(@user)
    segment.identify
  end

  def store_user_info
    # rubocop:disable Rails/SkipsModelValidations
    @user.update_columns(
      provider_token: auth_hash.credentials.token,
      name: auth_hash.info.nickname,
      email: auth_hash.info.email
    )
    # rubocop:enable Rails/SkipsModelValidations
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  def impersonate
    raise ActionController::RoutingError, 'Not Found' if Rails.env.production?

    @user = User.find_by(id: params[:id])
    session[:current_user_id] = @user.id if @user
    redirect_to '/'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
