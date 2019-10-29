# frozen_string_literal: true

module SpamRepositoryService
  module_function

  def call(repo_id)
    if SpamRepository.where(github_id: repo_id).first
      true
    else
      false
    end
  end
end
