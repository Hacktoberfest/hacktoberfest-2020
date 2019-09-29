# frozen_string_literal: true

module ProjectImportService
  module_function

  def call(query_string = nil)
    access_token = GithubTokenService.random
    api_client = GithubGraphqlApiClient.new(access_token: access_token)
    fetcher = HacktoberfestProjectFetcher.new(api_client: api_client)
    fetcher.fetch!(query_string)
    projects = fetcher.projects
    importer = HacktoberfestProjectImporter.new
    importer.import_all(projects)
  end
end
