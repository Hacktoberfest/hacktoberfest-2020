# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :require_user_logged_in!
  before_action :require_user_registered!, only: :show
  before_action :disallow_registered_user!, only: :registration
  before_action :require_user_moderator, only: [:management, :manage, :manage_patch, :ban, :unban]
  before_action :find_user_by_uid, only: [:manage, :manage_patch, :ban, :unban]

  # render current user profile
  def show
    TryUserTransitionService.call(@current_user)
    @presenter = ProfilePagePresenter.new(@current_user)
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

  def management
    @flagged_users = User.where(system_flagged: true, moderator_banned: false)
                         .order(system_flagged_at: :desc)
    @banned_users = User.where(moderator_banned: true)
                        .order(system_flagged: :asc, moderator_banned_at: :desc)
  end

  def manage
    p @user
  end

  def manage_patch
    @user.assign_attributes(params_for_manage)
    @user.save
    redirect_to manage_path(@user.uid)
  end

  def ban
    p @user
    @user.ban
    p @user
    redirect_to manage_path(@user.uid)
  end

  def unban
    @user.unban
    redirect_to manage_path(@user.uid)
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

  def params_for_manage
    params.require(:user).permit(:is_moderator, :moderator_notes)
  end

  def require_user_moderator
    unless current_user.is_moderator?
      render plain: 'not-authorized', status: :unauthorized
    end
  end

  def find_user_by_uid
    @user = User.find_by(uid: params[:user_uid])
  end
end
