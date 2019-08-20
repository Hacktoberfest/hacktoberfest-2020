# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index; end

  def profile
    @score = UserScoreboard.new(current_user,
                                ENV['start_date'],
                                ENV['end_date']).score
  end
end
