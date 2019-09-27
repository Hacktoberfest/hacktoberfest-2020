# frozen_string_literal: true

class TransitionAllUsersJob
  include Sidekiq::Worker
  sidekiq_options queue: :critical, retry: 3

  def perform
    User.select(:id).find_in_batches do |group|
      group.each { |user| UserTransitionJob.perform_async(user.id) }
    end
  end
end
