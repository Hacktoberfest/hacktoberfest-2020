# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :require_user_registration!, only: :show
  before_action :require_user_logged_in!, only: %i[edit update]

  # render current user profile
  def show
    scoreboard = UserScoreboard.new(@current_user)
    @score = scoreboard.score
    @pull_requests = scoreboard.pull_requests.select { |p| p.label_names != ['invalid'] }
    @invalid_pull_requests = scoreboard.pull_requests.select { |p| p.label_names == ['invalid'] }
  end

  # action to save registration
  def update
    if @current_user.update_registration_validations(params_for_registration)
      redirect_to session[:destination] || '/'
    else
      set_user_emails
      render 'users/edit'
    end
  end

  # action to render register form
  def edit
    @emails = UserEmailService.new(@current_user).emails
  end

  private

  def params_for_registration
    params.require(:user).permit(:email, :terms_acceptance, :marketing_emails)
  end
end
