# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :require_user_logged_in!
  before_action :require_user_registered!, only: :show
  before_action :disallow_registered_user!, only: :registration
  before_action :transform_categories, only: %i[register update]
  before_action :set_dropdowns, only: %i[registration edit]

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
      set_dropdowns
      render 'users/registration'
    end
  end

  def registration; end

  def edit; end

  def update
    @current_user.assign_attributes(params_for_update)
    if @current_user.save
      segment = SegmentService.new(@current_user)
      segment.identify(
        email: @current_user.email,
        category: @current_user.category,
        country: @current_user.country
      )
      redirect_to profile_path
    else
      set_dropdowns
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

  def set_dropdowns
    @emails = UserEmailService.new(@current_user).emails
    @categories = { 'Participant' => 'participant',
                    'Event Organizer' => 'organizer',
                    'Maintainer' => 'maintainer' }
  end

  def transform_categories
    return unless params[:user].present? && params[:user][:category].present?

    params[:user][:category] = params[:user][:category]
                               .reject(&:empty?)
                               .join(',')
  end

  def params_for_registration
    params.require(:user).permit(
      :email,
      :terms_acceptance,
      :digitalocean_marketing_emails,
      :intel_marketing_emails,
      :dev_marketing_emails,
      :category,
      :country
    )
  end

  def params_for_update
    params.require(:user).permit(
      :email,
      :category,
      :country
    )
  end
end
