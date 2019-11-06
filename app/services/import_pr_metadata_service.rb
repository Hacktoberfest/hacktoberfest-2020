# frozen_string_literal: true

module ImportPrMetadataService
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
      ImportOnePrMetadataJob.perform_async(pr.url)
    end
  end
end
