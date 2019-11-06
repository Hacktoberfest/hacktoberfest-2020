# frozen_string_literal: true

module GithubErrorHandler
  module_function

  HANDLED_ERRORS = [
    Octokit::AccountSuspended,
    GithubPullRequestService::UserNotFoundOnGithubError
  ].freeze

  def with_error_handling
    yield
  rescue *HANDLED_ERRORS => e
    process_github_error(e)
  end

  def process_github_error(error)
    case error
    when Octokit::AccountSuspended
      process_user_missing_error(error)
    when GithubPullRequestService::UserNotFoundOnGithubError
      process_user_missing_error(error)
    else
      raise error
    end
  end

  def process_user_missing_error(error)
    return unless (user_stat = UserStat.where(user_id: error.get_user.id).first)

    user_stat.destroy
  end
end
