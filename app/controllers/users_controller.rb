# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :require_user_logged_in!
  before_action :require_user_registered!, only: :show
  before_action :disallow_registered_user!, only: :registration

  # render current user profile
  def show
    TryUserTransitionService.call(@current_user)
    @presenter = ProfilePagePresenter.new(@current_user)
  end

  # action to save registration
  def register
    @current_user.assign_attributes(params_for_registration)
    if save_or_register(@current_user)
      redirect_to profile_path
    else
      set_user_emails
      render 'users/registration'
    end
  end

  # action to render register form
  def registration
    @categories = { 'Participant' => 'Participant',
                    'Event Organizer' => 'organizer',
                    'Maintainer' => 'maintainer' }
    set_user_emails
  end

  def edit
    set_user_emails
  end

  def update
    @current_user.assign_attributes(params_for_update)
    if @current_user.save
      segment = SegmentService.new(@current_user)
      segment.identify(email: @current_user.email)
      redirect_to profile_path
    else
      set_user_emails
      render 'users/edit'
    end
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
    params.require(:user).permit(
      :email,
      :terms_acceptance,
      :digitalocean_marketing_emails,
      :intel_marketing_emails,
      :dev_marketing_emails,
      :category
    )
  end

  def params_for_update
    params.require(:user).permit(:email)
  end
end
