# frozen_string_literal: true

module ReportAirtableUpdaterService
  module_function

  def call(report)
    if (repository = github_client.repository(report.github_repo_identifier))
      return if SpamRepositoryService.call(repository.id)

      # mark it as spam
      new_record = { "Repo ID": repository.id.to_s, "Repo Link": report.url }
      AirrecordTable.new.table('Spam Repos').create(new_record)
    end
  rescue Octokit::NotFound, Octokit::InvalidRepository
    # do nothing
  end

  def github_client
    Octokit::Client.new(access_token: GithubTokenService.random)
  end
end
