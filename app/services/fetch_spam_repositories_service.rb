# frozen_string_literal: true

module FetchSpamRepositoriesService
  module_function

  def call
    spam_repo_ids = AirrecordTable.new.all_records('Spam Repos').map do |repo|
      repo['Repo ID']&.to_i if repo['Verified?']
    end.compact

    create_new_spam_repos(spam_repo_ids)
    remove_absent_repos(spam_repo_ids)
  end

  def create_new_spam_repos(spam_repo_ids)
    spam_repo_ids.each do |spam_repo_id|
      SpamRepository.where(github_id: spam_repo_id).first_or_create
    end
  end

  def remove_absent_repos(spam_repo_ids)
    SpamRepository.all.map do |spam_repo|
      spam_repo.destroy unless spam_repo_ids.include?(spam_repo.github_id)
    end
  end
end
