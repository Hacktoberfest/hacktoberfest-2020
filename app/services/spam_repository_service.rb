# frozen_string_literal: true

module SpamRepositoryService
  module_function

  def call(repo_id)
    if AirrecordTable.new.airtable_key_present?
      table = AirrecordTable.new.table('Spam Repos')
      spam_repo_ids = table.all.map do |repo|
        repo['Repo ID']&.to_i if repo['Verified?']
      end.compact
      spam_repo_ids.include?(repo_id)
    else
      AirrecordTable.log_airbrake_warning
      return false
  end
end
