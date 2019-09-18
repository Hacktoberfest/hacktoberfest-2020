# frozen_string_literal: true

class HacktoberfestProjectFetcher
  NODE_LIMIT = 100

  attr_reader :projects

  def initialize(api_client:)
    @api_client = api_client
    @started = false
    @complete = false
    @end_cursor = nil
    @projects = []
    @errors = nil
  end

  def fetch!
    while fetching_incomplete?
      @started = true
      fetch_next_page
    end
  end

  private

  def fetching_incomplete?
    !@started || @has_next_page
  end

  def fetch_next_page
    query = HacktoberfestProjectQueryComposer.compose(
      results_per_page: NODE_LIMIT,
      cursor: @last_cursor
    )
    response = @api_client.request(query)

    if response_returns_expected_error?(response)
      @has_next_page = false
    elsif response_invalid?(response)
      raise HacktoberfestProjectFetcherError.new(
        'Invalid response received',
        errors: @errors,
        query: query
      )
    else
      search = response['data']['search']
      @has_next_page = search['pageInfo']['hasNextPage']
      @last_cursor = search['pageInfo']['endCursor']
      build_projects(search['edges'])
    end
  end

  def response_returns_expected_error?(response)
    if response['errors'].present? && response['errors'].size == 1
      response['errors'].first['message'].include?(
        'Something went wrong while executing your query. This is most likely a GitHub bug.'
      )
    end
  end

  def response_invalid?(response)
    @errors = response['errors'] if response['errors'].present?
    response['data'].blank?
  end

  def build_projects(edges)
    edges.each do |edge|
      issue = edge['node']
      next if issue_invalid?(issue)

      repository = issue['repository']
      project = {
        issue_database_id: issue['databaseId'],
        issue_number: issue['number'],
        issue_participants: issue['participants']['totalCount'],
        issue_timeline_events: issue['timeline']['totalCount'],
        issue_title: issue['title'],
        issue_url: issue['url'],
        repo_database_id: repository['databaseId'],
        repo_description: repository['description'],
        repo_code_of_conduct_url: repository.dig('codeOfConduct', 'url') || '',
        repo_forks: repository['forks']['totalCount'],
        repo_language: repository['primaryLanguage']['name'],
        repo_name: repository['name'],
        repo_name_with_owner: repository['nameWithOwner'],
        repo_stars: repository['stargazers']['totalCount'],
        repo_watchers: repository['watchers']['totalCount'],
        repo_url: repository['url']
      }
      @projects << project
    end
  end

  def issue_invalid?(issue)
    issue.blank? || issue_language_blank?(issue) || repo_description_blank?(issue) || issue_body_blank?(issue)
  end

  def issue_body_blank?(issue)
    issue['bodyText'].blank?
  end

  def issue_language_blank?(issue)
    issue['repository']['primaryLanguage'].blank?
  end

  def repo_description_blank?(issue)
    issue['repository']['description'].blank?
  end
end
