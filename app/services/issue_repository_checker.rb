# frozen_string_literal: true

class IssueRepositoryChecker
  def self.update_all
    Issue.includes(:repository).find_each do |issue|
      next unless issue.repository.banned?

      issue.destroy
    end
  end
end
