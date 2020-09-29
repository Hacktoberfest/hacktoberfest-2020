# frozen_string_literal: true

class ProjectImportJob
  include Sidekiq::Worker
  sidekiq_options queue: :default, retry: 3

  POPULAR_LANGUAGES = [
    'C#',
    'JavaScript',
    'PHP',
    'Python',
    'Go',
    'C++',
    'Java',
    'TypeScript',
    'Ruby'
  ].freeze

  def perform
    POPULAR_LANGUAGES.each do |language|
      ProjectImportService.call("language:#{language}")
    end
  end
end
