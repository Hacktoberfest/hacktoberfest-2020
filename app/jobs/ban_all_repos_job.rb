
# frozen_string_literal: true

class BanAllReposJob < ApplicationJob
  queue_as :ban_repos

  def perform 
    repo_ids_to_ban.map do |repo_id|
      BanRepoJob.perform_later(repo_id)
    end
  end

  def repo_ids_to_ban
    repos = AirrecordTable.new.table('Spam Repos')
    # binding.pry
    repos.all.map do |repo|
      repo.fields['Repo ID']
    end
  end
end
