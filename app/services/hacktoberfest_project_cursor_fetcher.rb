# frozen_string_literal: true
require 'pp'

class HacktoberfestProjectCursorFetcher
  NODE_LIMIT = 100

  CURSOR_QUERY = <<~GRAPHQL
    query FindHacktoberfestIssues($queryString: String!, $cursor: String) {
      rateLimit {
        cost
        limit
        remaining
        resetAt
      }
      search(query: $queryString, type: ISSUE, first: 100, after: $cursor) {
        issueCount
        pageInfo {
          endCursor
          hasNextPage
        }
      }
    }
  GRAPHQL

  attr_reader :cursors

  def initialize(api_client:)
    @api_client = api_client
    @started = false
    @complete = false
    @last_cursor = nil
    @errors = nil
    @cursors = []
  end

  def fetch!
    while fetching_incomplete?
      @started = true
      fetch_next_page
    end
    pp @cursors
  end

  private

  def fetching_incomplete?
    !@started || @has_next_page
  end

  def fetch_next_page
    variables = {
      queryString: 'state:open label:hacktoberfest',
      cursor: @last_cursor
    }
    response = @api_client.request(CURSOR_QUERY, variables)

    pp response
    if response_returns_expected_error?(response)
      @has_next_page = false
    elsif response_invalid?(response)
      raise HacktoberfestProjectFetcherError.new(
        'Invalid response received',
        errors: @errors,
      )
    else
      search = response['data']['search']
      @has_next_page = search['pageInfo']['hasNextPage']
      @last_cursor = search['pageInfo']['endCursor']
      @cursors << @last_cursor
      pp @last_cursor
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
end
