# frozen_string_literal: true

module ImportOnePrMetadataService
  module_function

  def call(url)
    pr_data = client.pull_request(*pull_request_args_from_url(url)).to_hash

    # using node_id here because that's what we
    # used previously as the pr_id in a PRStat. This way the data is consistent
    pr = PRStat.where(pr_id: pr_data[:node_id]).first_or_create(data: pr_data)
    pr.update(data: pr_data)
  end

  def client
    access_token = GithubTokenService.random
    Octokit::Client.new(access_token: access_token)
  end

  def pull_request_args_from_url(url)
    repo = url.split('/')[3] + '/' + url.split('/')[4]
    number = url.split('/').last

    [repo, number]
  end
end
