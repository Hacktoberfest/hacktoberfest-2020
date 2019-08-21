# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

# render current user profile
  def show
    @score = UserScoreboard.new(@current_user,
                                  ENV['start_date'],
                                  ENV['end_date']).score
  end

# action to save registration
  def update
    if params["user"]["confirmed"].to_i == 1
      @current_user.update(email: params["user"]["email"])
      redirect_to session[:destination] if @current_user.save
    else
      redirect_to register_form_path
    end
  end

# action to render register form
  def edit
    client = Octokit::Client.new(access_token: @current_user.provider_token)
    @emails = client.emails.select do |email|
      email unless email.visibility.nil?
    end.map { |email| email.email }
  end
end
