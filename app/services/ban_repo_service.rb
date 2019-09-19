# frozen_string_literal: true

module TryUserTransitionFromRegisteredService
  def self.call(repo_id)
    if repo = Repository.find_by_gh_database_id(repo_id)
      repo.banned? = true
      repo.save
    end
  end
end
