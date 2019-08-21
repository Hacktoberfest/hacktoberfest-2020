# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :require_user_registration!, only: :show
  before_action :require_user_logged_in!, only: %i[edit update]

  # render current user profile
  def show
    @score = UserScoreboard.new(@current_user,
                                ENV['START_DATE'],
                                ENV['END_DATE']).score
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
    set_user_emails
  end

  private

  def set_user_emails
    client = Octokit::Client.new(access_token: @current_user.provider_token)
    selected = client.emails.select do |email|
      email unless email.visibility.nil?
    end
    @emails = selected.map(&:email)
  end

  def params_for_registration
    params.require(:user).permit(:email, :terms_acceptance, :marketing_emails)
  end
end
