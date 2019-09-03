# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :require_user_registration!, only: :show
  before_action :require_user_logged_in!, only: %i[edit update]

  # render current user profile
  def show
    prs = PullRequestService.new(@current_user)
    @pull_requests = prs.all_by_state
    @score = prs.score
  end

  # action to save registration
  def update
    @current_user.assign_attributes(params_for_registration)
    if @current_user.register
      redirect_to session[:destination] || '/'
    else
      set_user_emails
      render 'users/edit'
    end
  end

  # action to render register form
  def edit
    set_user_emails
  end

  private

  def set_user_emails 
    @emails = UserEmailService.new(@current_user).emails
  end

  def params_for_registration
    params.require(:user).permit(:email, :terms_acceptance, :marketing_emails)
  end
end
