# frozen_string_literal: true

class ManagementController < ApplicationController
  before_action :require_user_logged_in!
  before_action :require_user_moderator!
  before_action :find_user_by_uid, only: [:show, :update, :ban, :unban]

  def index
    @flagged_users = User.where(system_flagged: true, moderator_banned: false)
                         .order(system_flagged_at: :desc)
    @banned_users = User.where(moderator_banned: true)
                        .order(system_flagged: :asc, moderator_banned_at: :desc)
  end

  def show
    p @user
  end

  def update
    @user.assign_attributes(params_for_update)
    @user.save
    redirect_to management_user_path(@user.uid)
  end

  def ban
    @user.ban
    redirect_to management_user_path(@user.uid)
  end

  def unban
    @user.unban
    redirect_to management_user_path(@user.uid)
  end

  private

  def params_for_update
    params.require(:user).permit(:is_moderator, :moderator_notes)
  end

  def require_user_moderator!
    unless current_user.is_moderator?
      render plain: 'not-authorized', status: :unauthorized
    end
  end

  def find_user_by_uid
    @user = User.find_by(uid: params[:user_uid])
  end
end
