# frozen_string_literal: true

module ImportRepoMetadataService
  module_function

  def call(repo_id)
    access_token = GithubTokenService.random
    api_client = Octokit::Client.new(access_token: access_token)

    repo = api_client.repo(repo_id).to_hash
    repo_stat = RepoStat.where(repo_id: repo_id).first_or_create(data: repo)
    repo_stat.update(data: repo)
  end
end
