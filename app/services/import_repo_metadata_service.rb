# frozen_string_literal: true

module ImportRepoMetadataService
  module_function

  def call(user)
    pr_data = user.pull_requests
    access_token = GithubTokenService.random
    api_client = Octokit::client.new(access_token: access_token)

    pr_data.map do |pr|
      repo_id = pr.github_pull_request.repo_id
      repo = api_client.repo(repo_id).to_hash
      RepoStat.where(repo_id: repo_id).first_or_create(data: repo)
    end
  end
end
