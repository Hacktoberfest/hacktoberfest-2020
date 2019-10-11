# frozen_string_literal: true

module BanAllReposService
  module_function

  def call
    repo_ids_to_ban.map do |repo_id|
      repo = Repository.find_by(gh_database_id: repo_id)
      repo&.update(banned: true)
    end
  end

  def repo_ids_to_ban
    if AirrecordTable.new.airtable_key_present?
      repos = AirrecordTable.new.table('Spam Repos')
      repos.all.map do |repo|
        repo.fields['Repo ID']&.to_i if repo.fields['Verified?']
      end.compact
    else
      AirrecordTable.log_airbrake_warning
      []
  end
end
