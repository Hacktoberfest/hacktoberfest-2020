# frozen_string_literal: true

module BanAllReposService
  def self.call
    repo_ids_to_ban.map do |repo_id|
      if repo = Repository.find_by_gh_database_id(repo_id)
        repo.update(banned: true)
      end
    end
  end

  def repo_ids_to_ban
    repos = AirrecordTable.new.table('Spam Repos')
    repos.all.map do |repo|
      repo.fields['Repo ID']
    end
  end
end
