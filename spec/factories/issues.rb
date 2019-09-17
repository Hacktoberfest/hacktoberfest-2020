# frozen_string_literal: true

FactoryBot.define do
  factory :issue do
    open { true }
    repository
    sequence(:gh_database_id) { |n| n }
    sequence(:number) { |n| n }
    sequence(:title) { |n| "Issue #{n}" }
    url { 'http://example.com' }
  end
end
