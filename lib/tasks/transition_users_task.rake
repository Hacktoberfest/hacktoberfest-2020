# frozen_string_literal: true

namespace :user do
  desc 'Transition all users'
  task transition: :environment do
    User.all.find_in_batches do |group|
      group.each { |user| UserTransitionJob.perform_later(user) }
    end
  end
end
