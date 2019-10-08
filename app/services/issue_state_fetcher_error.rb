# frozen_string_literal: true

class IssueStateFetcherError < StandardError
  attr_reader :errors, :query

  def initialize(message, errors:, query:)
    super(message)
    @errors = errors
    @query = query
  end
end
