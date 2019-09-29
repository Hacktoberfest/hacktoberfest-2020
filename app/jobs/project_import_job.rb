# frozen_string_literal: true

class ProjectImportJob
  include Sidekiq::Worker
  sidekiq_options queue: :default, retry: 7

  def perform(query_string = nil)
    ProjectImportService.call(query_string)
  end
end
