# frozen_string_literal: true

module ImportRepoMetadataService
  module_function

  def call(user)
    pr_data = user.pull_requests
    client = OctokitRetryableAPIClient.new(access_token: user.provider_token)

    pr_data.map do |pr|
      repo_id = pr.github_pull_request.repo_id
      repo = client.request(:repo, repo_id).to_hash
      RepoStat.where(repo_id: repo_id).first_or_create(data: repo)
    end
  end
end