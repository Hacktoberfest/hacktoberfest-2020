# frozen_string_literal: true

class UpdateAllIssuesJob
  include Sidekiq::Worker

  def perform
    Issue.select(:id).find_in_batches do |issue_group|
      issue_group.each do |issue|
        IssueUpdateJob.perform_async(issue.id)
      end
    end
  end
end
