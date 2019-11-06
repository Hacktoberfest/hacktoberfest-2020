# frozen_string_literal: true

module ReportAirtableUpdaterService
  module_function

  def call(report)
    if (repository = github_client.repository(report.github_repo_identifier))
      return if spammy_repo_report_exists?(repository.id)

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

  def spammy_repo_report_exists?(repo_id)
    previously_reported_repo_ids = AirrecordTable.new.all_records(
      'Spam Repos'
    ).map do |repo|
      repo['Repo ID']&.to_i if repo['Verified?'] || repo['Permitted?']
    end.compact
    previously_reported_repo_ids.include?(repo_id)
  end
end
