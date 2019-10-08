# frozen_string_literal: true

module BanAllReposService
  module_function

  def call
    repo_ids_to_ban.map do |repo_id|
      if repo = Repository.find_by(gh_database_id: repo_id)
        repo.update(banned: true)
      end
    end
  end

  def repo_ids_to_ban
    repos = AirrecordTable.new.table('Spam Repos')
    repos.all.map do |repo|
      repo.fields['Repo ID']&.to_i if repo.fields['Verified?']
    end.compact
  end
end
