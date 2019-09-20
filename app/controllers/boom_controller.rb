# frozen_string_literal: true

class BoomError < StandardError
  def message
    "Boom!"
  end
end

class BoomController < ApplicationController
  # raise the boom error!
  def show
    raise BoomError
  end
end
