namespace :user  do
  desc "try to transition all users from waiting state"
  task :try_transition_waiting_users do
    User.where(state == 'waiting').find_in_batches do |group|
      group.each { |user| TryUserTransitionFromRegistered(user) }
    end
  end
end