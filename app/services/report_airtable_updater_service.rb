# frozen_string_literal: true

class ReportAirtableUpdaterService
  NAME_WITH_OWNER_REGEX = /github.com\/([\w.-]+\/[\w.-]+)/

  def initialize(report)
    @report = report
  end

  def report
    begin
      if (repository = github_client.repository(@report.github_repo_identifier))
        return if SpamRepositoryService.call(repository.id)

        # mark it as spam
        new_record =  { "Repo ID": repository.id.to_s, "Repo Link": @url }
        AirrecordTable.new.table("Spam Repos").create(new_record)
      end
    rescue Octokit::NotFound, Octokit::InvalidRepository
      # do nothing
    end
  end

  private

  def github_client
    @github_client ||= Octokit::Client.new(
      access_token: GithubTokenService.random
    )
  end
end
