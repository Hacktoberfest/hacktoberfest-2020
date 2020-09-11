# frozen_string_literal: true

class ApiController < ApplicationController
  skip_before_action :set_current_user
  before_action :require_authentication

  def state
    user = User.find_by(uid: params[:user])
    render plain: if user.present?
                    user.completed_or_won? ? 'completed' : 'registered'
                  else
                    'not-found'
                  end
  end

  private

  def require_authentication
    return if valid_authentication?

    render plain: 'not-authorized', status: :unauthorized
  end

  def valid_authentication?
    request.headers['Authorization'] == ENV.fetch('HACKTOBERFEST_API_KEY')
  end
end
