
# frozen_string_literal: true

class TransitionAllUsersJob < ApplicationJob
  queue_as :default

  def perform
    User.all.find_in_batches do |group|
      group.each { |user| UserTransitionJob.perform_later(user) }
    end
  end
end
