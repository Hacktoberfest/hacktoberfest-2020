# frozen_string_literal: true

class IssueUpdateJob
  include Sidekiq::Worker
  sidekiq_options queue: :bulk, retry: 7

  def perform(issue_id)
    issue = Issue.includes(:repository).find(issue_id)
    IssueUpdateService.call(issue)
  end
end
