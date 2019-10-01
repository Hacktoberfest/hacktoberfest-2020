# frozen_string_literal: true

module SpamRepositoryService
  module_function

  def call(repo_id)
    table = AirrecordTable.new.table('Spam Repos')
    spam_repo_ids = table.all.map do |repo|
      repo['Repo ID']&.to_i if repo['Verified?']
    end
    spam_repo_ids.include?(repo_id)
  end
end
