# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index; end

  def profile
    @score = 3
  end
end
