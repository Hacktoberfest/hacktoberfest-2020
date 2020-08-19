module GithubErrorHandler
  module_function

  HANDLED_ERRORS = [
    Octokit::AccountSuspended,
    GithubPullRequestService::UserNotFoundOnGithubError
  ].freeze

  def with_error_handling(user)
    yield
  rescue *HANDLED_ERRORS => e
    process_github_error(e, user)
  end

  def process_github_error(error, user)
    ## rubocop:disable Rails/SkipsModelValidations
    user.update_attribute(:last_error, error.class)
    ## rubocop:enable Rails/SkipsModelValidations
    case error
    when Octokit::AccountSuspended
      process_user_missing_error(error, user)
    when GithubPullRequestService::UserNotFoundOnGithubError
      process_user_missing_error(error, user)
    else
      raise error
    end
  end

  def process_user_missing_error(error, user)
    user.deactivate
    
    return unless (user_stat = UserStat.where(user_id: user.id).first)

    user_stat.destroy
  end
end
