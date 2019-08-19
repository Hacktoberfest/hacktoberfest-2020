# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index; end

  def profile
    # UserScoreboard.new(current_user, ENV['start_date'], ENV['end_date'])
    @score = 3
  end
end
