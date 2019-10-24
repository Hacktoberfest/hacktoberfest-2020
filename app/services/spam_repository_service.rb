# frozen_string_literal: true

module SpamRepositoryService
  module_function

  def call(repo_id)
    spam_repo_ids = Rails.cache.fetch('SpamRepositoryService/spam_repo_ids', expires_in: 10.minutes) do
      AirrecordTable.new.all_records('Spam Repos').map do |repo|
        repo['Repo ID']&.to_i if repo['Verified?']
      end.compact
    end
    spam_repo_ids.include?(repo_id)
  end
end
