# frozen_string_literal: true

def log(str)
  Rails.logger.info str
end

def log_error(str)
  Rails.logger.error str
end

namespace :github do
  desc 'Fetch and import Hacktoberfest projects'
  task fetch_and_import_hacktoberfest_projects: :environment do
    access_token = ENV.fetch('GITHUB_ACCESS_TOKEN')
    api_client = GithubGraphqlApiClient.new(access_token: access_token)
    fetcher = HacktoberfestProjectFetcher.new(api_client: api_client)
    fetcher.fetch!
    projects = fetcher.projects
    importer = HacktoberfestProjectImporter.new
    importer.import_all(projects)
  rescue HacktoberfestProjectFetcherError => e
    log_error(e.message)
  rescue StandardError => e
    log_error(e.message)
  end

  desc 'Fetch projects for all popular languages on github'
  task fetch_popular_languages_projects: :environment do
    # This list was directly taken from the Popular Languages select box on
    # GitHub's advanced search page: https://github.com/search/advanced
    POPULAR_LANGUAGES = [
      'ActionScript',
      'C',
      'C#',
      'C++',
      'Clojure',
      'CoffeeScript',
      'CSS',
      'Go',
      'Haskell',
      'HTML',
      'Java',
      'JavaScript',
      'Lua',
      'MATLAB',
      'Objective-C',
      'Perl',
      'PHP',
      'Python',
      'R',
      'Ruby',
      'Scala',
      'Shell',
      'Swift',
      'TeX',
      'Vim script'
    ].freeze
    POPULAR_LANGUAGES.each do |language|
      ProjectImportJob.perform_async("language:#{language}")
    end
  end
end
