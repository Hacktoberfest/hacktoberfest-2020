# frozen_string_literal: true

class UpdateAllIssuesQualityJob
  include Sidekiq::Worker
  sidekiq_options queue: :default, retry: 7

  def perform
    IssueQualityUpdater.update_all
  end
end
