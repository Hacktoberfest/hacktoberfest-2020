# frozen_string_literal: true

module ReportAirtableUpdaterService
  module_function

  def call(report)
    if (repository = github_client.repository(report.github_repo_identifier))
      # Existing record, update it
      if (existing_record = spammy_repo_report(repository.id))
        existing_record['Reports'] += 1
        existing_record['Year'] = Hacktoberfest.start_date.year
        existing_record.save
        return existing_record
      end

      # Create a new record to mark it as spam
      new_record = {
        "Repo ID": repository.id.to_s,
        "Repo Link": report.url,
        Reports: 1,
        Year: Hacktoberfest.start_date.year
      }
      AirrecordTable.new.table('Spam Repos').create(new_record)
    end
  rescue Octokit::NotFound, Octokit::InvalidRepository
    # do nothing
  end

  def github_client
    Octokit::Client.new(access_token: GithubTokenService.random)
  end

  def spammy_repo_report(repo_id)
    AirrecordTable.new.all_records('Spam Repos')
                  .select { |repo| repo['Repo ID']&.to_i == repo_id }
                  .first
  end
end
