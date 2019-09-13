#idk what im doing

namespace :user  do
  desc "try to transition all users from registered state"
  task :try_transition_registered_users do
    User.where(state == 'registered').find_in_batches do |group|
      group.each { |user| TryUserTransitionFromRegistered(user) }
    end
  end
end