# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    current_user
  end
end
