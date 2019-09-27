
# frozen_string_literal: true

class TransitionAllUsersJob
  include Sidekiq::Worker

  def perform
    User.select(:id).find_in_batches do |group|
      group.each { |user_id| UserTransitionJob.perform_async(user_id) }
    end
  end
end
