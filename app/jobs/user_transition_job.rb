class UserTransitionJob < ApplicationJob
  queue_as :default

  def perform(user)
    TryUserTransitionService.call(user)
  end
end
