# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HacktoberfestProjectFetcherError do
  it 'exposes an errors array and the query that led to the errors' do
    errors = [1, 2, 3]
    query = 'To be or not to be?'
    message = 'That is the question'

    error = HacktoberfestProjectFetcherError.new(
      message,
      errors: errors,
      query: query
    )

    expect(error.errors).to eq errors
    expect(error.query).to eq query
    expect(error.message).to eq message
  end
end
