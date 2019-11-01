# frozen_string_literal: true

module ImportOnePrMetadataService
  module_function

  def call(url)
    access_token = GithubTokenService.random
    api_client = Octokit::Client.new(access_token: access_token)

    repo = url.split('/')[3] + '/' + url.split('/')[4]
    number = url.split('/').last

    pr_data = api_client.pull_request(repo, number).to_hash
    
    pr = PRStat.where(pr_id: pr_data[:node_id]).first_or_create(data: pr_data)
    pr.update(data: pr_data)
  end
end
