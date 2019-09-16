# frozen_string_literal: true

class UserTransitionJob < ApplicationJob
  queue_as :default

  def perform(user)
    TryUserTransitionService.call(user)
  end
end
