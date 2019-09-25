# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :require_user_logged_in!
  before_action :require_user_registration!, only: :show

  # render current user profile
  def show
    TryUserTransitionService.call(@current_user)
  end

  # action to save registration
  def update
    @current_user.assign_attributes(params_for_registration)
    if save_or_register(@current_user)
      render 'users/update'
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

  def save_or_register(user)
    if user.can_register?
      user.register
    else
      user.save
    end
  end

  def set_user_emails
    @emails = UserEmailService.new(@current_user).emails
  end

  def params_for_registration
    params.require(:user).permit(:email, :terms_acceptance, :marketing_emails)
  end
end
