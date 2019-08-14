# frozen_string_literal: true


class UsersController < ApplicationController

def index
  users = User.order("id ASC")
  render json: users
end

def show
  user = User.find_by_id(params[:id])

  if user.nil?
    render json: { error: "User for id #{params[:id]} not found" },
           status: :not_found
  else
    render json: user
  end
end

def create
  user = (User.new, params)

  if user.save
    render json: user
  else
    render json: { errors: user.errors.full_messages }, status: :bad_request
  end
end

end
