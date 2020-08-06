# frozen_string_literal: true

# 4 pull requests with 2 invalid dates
ARRAY_WITH_INVALID_DATES = [
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NDc0Nzk5ODQ=',
    'title' => 'Results by cookie',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/peek/peek/pull/79',
    'createdAt' => (Time.parse(ENV['NOW_DATE']) - 4.years).to_s, # This is before the event
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NTE0MTg4ODg=',
    'title' => 'Update README.md',
    'body' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/vulume/Cordova-DBCamera/pull/1',
    'createdAt' => (Time.parse(ENV['NOW_DATE']) - 4.years + 1.month).to_s, # This is before the event
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NjkyNjE4Mjk=',
    'title' => 'Add natural layer',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/syl20bnr/spacemacs/pull/6012',
    'createdAt' => (Time.parse(ENV['NOW_DATE']) - 8.days).to_s, # This is valid, eligible
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0OTA4ODAzMzQ=',
    'title' => 'Coercion type systems',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/intridea/hashie/pull/379',
    'createdAt' => (Time.parse(ENV['NOW_DATE']) - 9.days).to_s, # This is valid, eligible
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 } }
].freeze

# 4 pull_requests with 4 invalid dates & 2 invalid labels
ARRAY_WITH_INVALID_DATES_AND_INVALID_LABEL = [
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NDc0Nzk5ODQ=',
    'title' => 'Results by cookie',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/peek/peek/pull/79',
    'createdAt' => (Time.parse(ENV['NOW_DATE']) - 4.years).to_s, # This is before the event
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NTE0MTg4ODg=',
    'title' => 'Update README.md',
    'body' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/vulume/Cordova-DBCamera/pull/1',
    'createdAt' => (Time.parse(ENV['NOW_DATE']) - 4.years + 1.month).to_s, # This is before the event
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NjkyNjE4Mjk=',
    'title' => 'Add natural layer',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/syl20bnr/spacemacs/pull/6012',
    'createdAt' => (Time.parse(ENV['NOW_DATE']) - 3.years - 5.months).to_s, # This is before the event
    'labels' => { 'edges': [{ 'node': { 'name': '❌ Invalid' } }] },
    'repository' => { 'databaseId' => 123 } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0OTA4ODAzMzQ=',
    'title' => 'Coercion type systems',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/intridea/hashie/pull/379',
    'createdAt' => (Time.parse(ENV['NOW_DATE']) - 3.years).to_s, # This is before the event
    'labels' => { 'edges': [{ 'node': { 'name': 'Invalid' } }] },
    'repository' => { 'databaseId' => 123 } }
].freeze

# 5 pull requests with 3 valid dates & 2 invalid labels
ARRAY_WITH_INVALID_LABEL = [
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NDc0Nzk5ODQ=',
    'title' => 'Results by cookie',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/peek/peek/pull/79',
    'createdAt' => (Time.parse(ENV['NOW_DATE']) - 8.days).to_s, # This is valid, eligible
    'labels' => { 'edges' => [{ 'node': { 'name': '❌ Invalid' } }] }, # Invalid label should make it invalid
    'repository' => { 'databaseId' => 123 } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NTE0MTg4ODg=',
    'title' => 'Update README.md',
    'body' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/vulume/Cordova-DBCamera/pull/1',
    'createdAt' => (Time.parse(ENV['NOW_DATE']) - 9.day).to_s, # This is valid, eligible
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NjkyNjE4Mjk=',
    'title' => 'Add natural layer',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/syl20bnr/spacemacs/pull/6012',
    'createdAt' => (Time.parse(ENV['NOW_DATE']) - 10.days).to_s, # This is valid, eligible
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0OTA4ODAzMzQ=',
    'title' => 'Coercion type systems',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/intridea/hashie/pull/379',
    'createdAt' => (Time.parse(ENV['NOW_DATE']) - 11.days).to_s, # This is valid, eligible
    'labels' => { 'edges': [{ 'node': { 'name': 'Invalid' } }] }, # Invalid label should make it invalid
    'repository' => { 'databaseId' => 123 } },
  { 'id' => 'MDExOlBdfsfafsfdsF1ZXN0OTA4ODAzMzQ=',
    'title' => 'Timeline Feature',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/intridea/hashie/pull/379',
    'createdAt' => (Time.parse(ENV['NOW_DATE']) - 12.days).to_s, # This is valid, eligible
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 } }
].freeze

# 5 pull requests with valid dates and valid labels
VALID_ARRAY = [
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NDc0Nzk5ODQ=',
    'title' => 'Results by cookie',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/peek/peek/pull/79',
    'createdAt' => (Time.parse(ENV['NOW_DATE']) - 8.days).to_s, # This is valid, eligible
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NTE0MTg4ODg=',
    'title' => 'Update README.md',
    'body' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/vulume/Cordova-DBCamera/pull/1',
    'createdAt' => (Time.parse(ENV['NOW_DATE']) - 9.days).to_s, # This is valid, eligible
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NjkyNjE4Mjk=',
    'title' => 'Add natural layer',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/syl20bnr/spacemacs/pull/6012',
    'createdAt' => (Time.parse(ENV['NOW_DATE']) - 10.days).to_s, # This is valid, eligible
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0OTA4ODAzMzQ=',
    'title' => 'Coercion type systems',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/intridea/hashie/pull/379',
    'createdAt' => (Time.parse(ENV['NOW_DATE']) - 11.days).to_s, # This is valid, eligible
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 } },
  { 'id' => 'MDExOlBdfsfafsfdsF1ZXN0OTA4ODAzMzQ=',
    'title' => 'Timeline Feature',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/intridea/hashie/pull/379',
    'createdAt' => (Time.parse(ENV['NOW_DATE']) - 12.days).to_s, # This is valid, eligible
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 } }
].freeze

# 4 pull requests all with timestamps older than 7 days, eligible/mature
MATURE_ARRAY = [
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NDc0Nzk5ODQ=',
    'title' => 'Results by cookie',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/peek/peek/pull/79',
    'createdAt' => (Time.parse(ENV['NOW_DATE']) - 8.days).to_s,
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NTE0MTg4ODg=',
    'title' => 'Update README.md',
    'body' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/vulume/Cordova-DBCamera/pull/1',
    'createdAt' => (Time.parse(ENV['NOW_DATE']) - 9.days).to_s,
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NjkyNjE4Mjk=',
    'title' => 'Add natural layer',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/syl20bnr/spacemacs/pull/6012',
    'createdAt' => (Time.parse(ENV['NOW_DATE']) - 10.days).to_s,
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0OTA4ODAzMzQ=',
    'title' => 'Coercion type systems',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/intridea/hashie/pull/379',
    'createdAt' => (Time.parse(ENV['NOW_DATE']) - 11.days).to_s,
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 } }
].freeze

# 4 pull requests with timestamps less than 7 days old, maturing
IMMATURE_ARRAY = [
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NDc0Nzk5ODQ=',
    'title' => 'Results by cookie',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/peek/peek/pull/79',
    'createdAt' => (Time.parse(ENV['NOW_DATE']) - 2.days).to_s,
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NTE0MTg4ODg=',
    'title' => 'Update README.md',
    'body' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/vulume/Cordova-DBCamera/pull/1',
    'createdAt' => (Time.parse(ENV['NOW_DATE']) - 3.days).to_s,
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NjkyNjE4Mjk=',
    'title' => 'Add natural layer',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/syl20bnr/spacemacs/pull/6012',
    'createdAt' => (Time.parse(ENV['NOW_DATE']) - 4.days).to_s,
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0OTA4ODAzMzQ=',
    'title' => 'Coercion type systems',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/intridea/hashie/pull/379',
    'createdAt' => (Time.parse(ENV['NOW_DATE']) - 5.days).to_s,
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 } }
].freeze

MIXED_MATURITY_ARRAY = IMMATURE_ARRAY[0..1] + MATURE_ARRAY[2..3]

PR_DATA = {
  valid_array: VALID_ARRAY,
  array_with_invalid_labels: ARRAY_WITH_INVALID_LABEL,
  array_with_invalid_dates: ARRAY_WITH_INVALID_DATES,
  invalid_array: ARRAY_WITH_INVALID_DATES_AND_INVALID_LABEL,
  mature_array: MATURE_ARRAY,
  immature_array: IMMATURE_ARRAY,
  mixed_maturity_array: MIXED_MATURITY_ARRAY
}.freeze

module PullRequestFilterHelper
  def pull_request_data(pr_array)
    pr_array.map do |hash|
      GithubPullRequest.new(Hashie::Mash.new(hash))
    end
  end

  class << self
    include PullRequestFilterHelper
  end
end
