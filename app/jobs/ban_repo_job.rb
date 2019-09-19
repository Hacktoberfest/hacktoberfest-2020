
# frozen_string_literal: true

class BanRepoJob < ApplicationJob
  queue_as :ban_repos

  def perform(repo_id)
    if repo = Repository.find_by_github_id(repo_id)
      repo_to_ban.banned = true
    end
  end
end
