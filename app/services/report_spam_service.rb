# frozen_string_literal: true

class ReportSpamService
  NAME_WITH_OWNER_REGEX = /github.com\/([\w.-]+\/[\w.-]+)/

  def initialize(url)
    @url = url.strip
  end

  def report
    return unless valid?

    begin
      if (repository = github_client.repository(name_with_owner))
        return if SpamRepositoryService.call(repository.id)

        # mark it as spam
        new_record =  { "Repo ID": repository.id.to_s, "Repo Link": @url }
        AirrecordTable.new.table("Spam Repos").create(new_record)
      end
    rescue Octokit::NotFound
      # do nothing
    end
  end

  private
  
  def name_with_owner
    if name_with_owner_matches
      name_with_owner_matches[1]
    else
      nil
    end
  end

  def name_with_owner_matches
    @name_with_owner_matches ||= @url.match(NAME_WITH_OWNER_REGEX)
  end

  def valid?
    name_with_owner.present?
  end

  def github_client
    @github_client ||= Octokit::Client.new(access_token: GithubTokenService.random)
  end
end