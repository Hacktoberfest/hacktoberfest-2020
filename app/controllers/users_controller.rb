# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :require_user_logged_in!
  before_action :require_user_registered!, only: :show
  before_action :disallow_registered_user!, only: :registration

  # render current user profile
  def show
    TryUserTransitionService.call(current_user)
    @presenter = ProfilePagePresenter.new(current_user)
  end

  # action to save registration
  def register
    @current_user.assign_attributes(params_for_registration)
    if save_or_register(@current_user)
      render 'users/registered'
    else
      set_user_emails
      render 'users/registration'
    end
  end

  # action to render register form
  def registration
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
