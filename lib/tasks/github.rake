# frozen_string_literal: true

def log(str)
  Rails.logger.info str
end

def log_error(str)
  Rails.logger.error str
end

namespace :github do
  desc 'Fetch projects for all popular languages on github'
  task fetch_popular_languages_projects: :environment do
    # This list was directly taken from the Popular Languages select box on
    # GitHub's advanced search page: https://github.com/search/advanced
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

    POPULAR_LANGUAGES.each do |language|
      ProjectImportService.call("language:#{language}")
    end
  end
end
