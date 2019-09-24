# frozen_string_literal: true

class IssueUpdateJob < ApplicationJob
  queue_as :transition

  def perform(issue_id)
    issue = Issue.includes(:repository).find(issue_id)
    IssueUpdateService.call(issue)
  end
end
