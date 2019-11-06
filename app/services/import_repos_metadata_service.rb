# frozen_string_literal: true

module ImportReposMetadataService
  module_function

  def call(user)
    pr_service = PullRequestService.new(user, randomize_token: true)

    begin
      pr_data = pr_service.all
    rescue GithubPullRequestService::UserNotFoundOnGithubError
      user_stat = UserStat.where(user_id: user.id).first

      user_stat.destroy
      return
    end

    pr_data.map do |pr|
      repo_id = pr.github_pull_request.repo_id
      ImportRepoMetadataJob.perform_async(repo_id)
    end
  end
end
