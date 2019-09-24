# frozen_string_literal: true

class UpdateAllIssuesJob < ApplicationJob
  queue_as :transition_all

  def perform
    Issue.select(:id).find_in_batches do |issue_group|
      issue_group.each do |issue|
        IssueUpdateJob.perform_later(issue.id)
      end
    end
  end
end
