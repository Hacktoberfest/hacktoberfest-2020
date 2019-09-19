Sidekiq.configure_server do |config|
  config.periodic do |mgr|
    # first arg is chron tab syntax for "every day at 1 am"
    mgr.register('0 1 * * *', TransitionAllUsersJob, retry: 2, queue: "transition_all")
  end
end