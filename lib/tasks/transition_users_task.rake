# frozen_string_literal: true

namespace :users do
  desc 'Transition all users'
  task transition: :environment do
    TransitionAllUsersJob.perform_async
  end
end
