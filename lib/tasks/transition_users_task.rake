# frozen_string_literal: true

namespace :users do
  desc 'Transition all users'
  task transition: :environment do
    TransitionAllUsersJob.perform_async
  end

  desc 'Retry completing all users'
  task retry_complete: :environment do
    User.where(state: 'incompleted')
        .where.not(waiting_since: nil)
        .each do |user|
      user.retry_complete
    rescue Faraday::ClientError
      # No retries in this case
    end
  end
end
