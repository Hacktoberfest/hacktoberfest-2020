# frozen_string_literal: true

module ImportReposMetadataService
  module_function

  def call(user)
    pr_service = PullRequestService.new(user, randomize_token: true)
    pr_data = pr_service.all

    return unless pr_data

    pr_data.map do |pr|
      repo_id = pr.github_pull_request.repo_id
      ImportRepoMetadataJob.perform_async(repo_id)
    end
  end
end
