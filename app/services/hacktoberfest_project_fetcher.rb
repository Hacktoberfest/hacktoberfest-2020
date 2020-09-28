# frozen_string_literal: true

# rubocop:disable Metrics/ClassLength
class HacktoberfestProjectFetcher
  NODE_LIMIT = 1
  MAX_RETRIES = ENV.fetch('IMPORT_MAX_RETRIES', 7).to_i

  attr_reader :projects

  def initialize(api_client:)
    @api_client = api_client
    @started = false
    @complete = false
    @end_cursor = nil
    @projects = []
    @errors = nil
    @query_string = nil
  end

  def fetch!(query_string = nil)
    @query_string = query_string
    while fetching_incomplete?
      @started = true
      fetch_next_page
    end
  end

  private

  def fetching_incomplete?
    !@started || @has_next_page
  end

  def api_request_with_retries(query)
    retry_count = 0
    begin
      response = @api_client.request(query)
    rescue Faraday::ClientError => e
      if e.response[:status] == 502
        if retry_count < MAX_RETRIES
          retry_count += 1
          retry
        else
          raise HacktoberfestProjectFetcherError.new('Max retries exceeded',
                                                     errors: @errors,
                                                     query: query)
        end
      end
    end
    response
  end

  def fetch_next_page
    query = HacktoberfestProjectQueryComposer.compose(
      query_string: @query_string,
      results_per_page: NODE_LIMIT,
      cursor: @last_cursor
    )

    response = api_request_with_retries(query)

    if response_invalid?(response)
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
    issue.blank? ||
      issue_language_blank?(issue) ||
      repo_description_blank?(issue) ||
      issue_body_blank?(issue)
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
# rubocop:enable Metrics/ClassLength
