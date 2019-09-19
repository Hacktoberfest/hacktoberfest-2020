
# frozen_string_literal: true

class TransitionAllUsersJob < ApplicationJob
  queue_as :default

  def perform
    User.select(:id).find_in_batches do |group|
      group.each { |user_id| UserTransitionJob.perform_later(user_id) }
    end
  end
end
