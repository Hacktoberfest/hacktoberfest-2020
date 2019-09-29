# frozen_string_literal: true

module ProjectImportService
  module_function

  def call
    access_token = GithubTokenService.random
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

  def log_error(str)
    Rails.logger.error str
  end
end
