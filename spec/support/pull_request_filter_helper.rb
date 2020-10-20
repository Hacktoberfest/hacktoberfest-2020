# frozen_string_literal: true

# 4 pull requests with 2 invalid dates
ARRAY_WITH_INVALID_DATES = [
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NDc0Nzk5ODQ=',
    'title' => 'Results by cookie',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/peek/peek/pull/79',
    # This is before the event
    'createdAt' => (Time.zone.parse(ENV['NOW_DATE']) - 4.years).to_s,
    'labels' => { 'edges' => [] },
    'merged' => true,
    'repository' => {
      'databaseId' => 123,
      'repositoryTopics' => { 'edges': [
        { 'node': { 'topic': { 'name': 'Hacktoberfest' } } }
      ] }
    } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NTE0MTg4ODg=',
    'title' => 'Update README.md',
    'body' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/vulume/Cordova-DBCamera/pull/1',
    # This is before the event
    'createdAt' => (Time.zone.parse(ENV['NOW_DATE']) - 4.years + 1.month).to_s,
    'labels' => { 'edges' => [] },
    'merged' => true,
    'repository' => {
      'databaseId' => 123,
      'repositoryTopics' => { 'edges': [
        { 'node': { 'topic': { 'name': 'Hacktoberfest' } } }
      ] }
    } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NjkyNjE4Mjk=',
    'title' => 'Add natural layer',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/syl20bnr/spacemacs/pull/6012',
    # This is valid, eligible
    'createdAt' => (Time.zone.parse(ENV['NOW_DATE']) - 15.days).to_s,
    'labels' => { 'edges' => [] },
    'merged' => true,
    'repository' => {
      'databaseId' => 123,
      'repositoryTopics' => { 'edges': [
        { 'node': { 'topic': { 'name': 'Hacktoberfest' } } }
      ] }
    } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0OTA4ODAzMzQ=',
    'title' => 'Coercion type systems',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/intridea/hashie/pull/379',
    # This is valid, eligible
    'createdAt' => (Time.zone.parse(ENV['NOW_DATE']) - 16.days).to_s,
    'labels' => { 'edges' => [] },
    'merged' => true,
    'repository' => {
      'databaseId' => 123,
      'repositoryTopics' => { 'edges': [
        { 'node': { 'topic': { 'name': 'Hacktoberfest' } } }
      ] }
    } }
].freeze

# 4 pull_requests with 4 invalid dates & 2 invalid labels
ARRAY_WITH_INVALID_DATES_AND_INVALID_LABEL = [
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NDc0Nzk5ODQ=',
    'title' => 'Results by cookie',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/peek/peek/pull/79',
    # This is before the event
    'createdAt' => (Time.zone.parse(ENV['NOW_DATE']) - 4.years).to_s,
    'labels' => { 'edges' => [] },
    'merged' => true,
    'repository' => {
      'databaseId' => 123,
      'repositoryTopics' => { 'edges': [
        { 'node': { 'topic': { 'name': 'Hacktoberfest' } } }
      ] }
    } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NTE0MTg4ODg=',
    'title' => 'Update README.md',
    'body' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/vulume/Cordova-DBCamera/pull/1',
    # This is before the event
    'createdAt' => (Time.zone.parse(ENV['NOW_DATE']) - 4.years + 1.month).to_s,
    'labels' => { 'edges' => [] },
    'merged' => true,
    'repository' => {
      'databaseId' => 123,
      'repositoryTopics' => { 'edges': [
        { 'node': { 'topic': { 'name': 'Hacktoberfest' } } }
      ] }
    } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NjkyNjE4Mjk=',
    'title' => 'Add natural layer',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/syl20bnr/spacemacs/pull/6012',
    # This is before the event
    'createdAt' => (Time.zone.parse(ENV['NOW_DATE']) - 3.years - 5.months).to_s,
    'labels' => { 'edges': [{ 'node': { 'name': '❌ Invalid' } }] },
    'repository' => {
      'databaseId' => 123,
      'repositoryTopics' => { 'edges': [
        { 'node': { 'topic': { 'name': 'Hacktoberfest' } } }
      ] }
    } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0OTA4ODAzMzQ=',
    'title' => 'Coercion type systems',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/intridea/hashie/pull/379',
    # This is before the event
    'createdAt' => (Time.zone.parse(ENV['NOW_DATE']) - 3.years).to_s,
    'labels' => { 'edges': [{ 'node': { 'name': 'Invalid' } }] },
    'repository' => {
      'databaseId' => 123,
      'repositoryTopics' => { 'edges': [
        { 'node': { 'topic': { 'name': 'Hacktoberfest' } } }
      ] }
    } }
].freeze

INVALID_EMOJI_LABEL_PR = {
  'id' => 'MDExOlB1bGxSZXF1ZXN0NDc0Nzk5ODQ=',
  'title' => 'Results by cookie',
  'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
    tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
  'url' => 'https://github.com/peek/peek/pull/79',
  # This is valid, eligible
  'createdAt' => (Time.zone.parse(ENV['NOW_DATE']) - 15.days).to_s,
  # Invalid label should make it invalid
  'labels' => { 'edges' => [{ 'node': { 'name': '❌ Invalid' } }] },
  'repository' => {
    'databaseId' => 123,
    'repositoryTopics' => { 'edges': [
      { 'node': { 'topic': { 'name': 'Hacktoberfest' } } }
    ] }
  }
}.freeze

INVALID_LABEL_PR = {
  'id' => 'MDExOlB1bGxSZXF1ZXN0OTA4ODAzMzQj=',
  'title' => 'Coercion type systems',
  'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
    tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
  'url' => 'https://github.com/intridea/hashie/pull/379',
  # This is valid, eligible
  'createdAt' => (Time.zone.parse(ENV['NOW_DATE']) - 18.days).to_s,
  # Invalid label should make it invalid
  'labels' => { 'edges' => [{ 'node': { 'name': 'Invalid' } }] },
  'repository' => {
    'databaseId' => 123,
    'repositoryTopics' => { 'edges': [
      { 'node': { 'topic': { 'name': 'Hacktoberfest' } } }
    ] }
  }
}.freeze

SPAM_LABEL_PR = {
  'id' => 'MDExOlB1bGxSZXF1ZXN0OTA4ODAzMzQ=',
  'title' => 'Coercion type systems',
  'body' =>
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
  tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
  'url' => 'https://github.com/intridea/hashie/pull/379',
  # This is valid, eligible
  'createdAt' => (Time.zone.parse(ENV['NOW_DATE']) - 18.days).to_s,
  # Spam label should make it invalid
  'labels' => { 'edges' => [{ 'node': { 'name': 'Spam' } }] },
  'repository' => {
    'databaseId' => 123,
    'repositoryTopics' => { 'edges': [
      { 'node': { 'topic': { 'name': 'Hacktoberfest' } } }
    ] }
  }
}.freeze

LONG_SPAM_LABEL_PR = {
  'id' => 'MDExOlB1bGxSZXF1ZXN0OTA4ODAzMzQ=',
  'title' => 'Coercion type systems',
  'body' =>
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
  tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
  'url' => 'https://github.com/intridea/hashie/pull/379',
  # This is valid, eligible
  'createdAt' => (Time.zone.parse(ENV['NOW_DATE']) - 18.days).to_s,
  # Spam label should make it invalid
  'labels' => { 'edges' => [{ 'node': { 'name': 'This is a spam PR' } }] },
  'repository' => {
    'databaseId' => 123,
    'repositoryTopics' => { 'edges': [
      { 'node': { 'topic': { 'name': 'Hacktoberfest' } } }
    ] }
  }
}.freeze

ELIGIBLE_PR = {
  'id' => 'MDExOlB1bGxSZXF1ZXN0NTE0MTg4ODg=',
  'title' => 'Update README.md',
  'body' =>
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
  tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
  'url' => 'https://github.com/vulume/Cordova-DBCamera/pull/1',
  # This is valid, eligible
  'createdAt' => (Time.zone.parse(ENV['NOW_DATE']) - 16.days).to_s,
  'labels' => { 'edges': [{ 'node': { 'name': 'hacktoberfest-accepted' } }] },
  'repository' => {
    'databaseId' => 123,
    'repositoryTopics' => { 'edges' => [] }
  }
}.freeze

MISSING_TOPIC_PR = {
  'id' => 'MDExOlB1bGxSZXF1ZXN0NTE0MTg4ODg=',
  'title' => 'Update README.md',
  'body' =>
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
  tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
  'url' => 'https://github.com/vulume/Cordova-DBCamera/pull/1',
  # This is valid, eligible
  'createdAt' => (Time.zone.parse(ENV['NOW_DATE']) - 16.days).to_s,
  'labels' => { 'edges' => [] },
  'merged' => true,
  'repository' => {
    'databaseId' => 123,
    # No hacktoberfest topic, so its invalid
    'repositoryTopics' => { 'edges' => [] }
  }
}.freeze

UNMERGED_PR = {
  'id' => 'MDExOlB1bGxSZXF1ZXN0NTE0MTg4ODg=',
  'title' => 'Update README.md',
  'body' =>
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
  tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
  'url' => 'https://github.com/vulume/Cordova-DBCamera/pull/1',
  # This is valid, eligible
  'createdAt' => (Time.zone.parse(ENV['NOW_DATE']) - 16.days).to_s,
  'labels' => { 'edges' => [] },
  'repository' => {
    'databaseId' => 123,
    'repositoryTopics' => { 'edges': [
      { 'node': { 'topic': { 'name': 'Hacktoberfest' } } }
    ] }
  }
}.freeze

# 5 pull requests with 3 valid dates & 2 invalid labels
ARRAY_WITH_INVALID_LABEL = [
  INVALID_EMOJI_LABEL_PR,
  ELIGIBLE_PR,
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NjkyNjE4Mjk=',
    'title' => 'Add natural layer',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/syl20bnr/spacemacs/pull/6012',
    # This is valid, eligible
    'createdAt' => (Time.zone.parse(ENV['NOW_DATE']) - 17.days).to_s,
    'labels' => { 'edges' => [] },
    'merged' => true,
    'repository' => {
      'databaseId' => 123,
      'repositoryTopics' => { 'edges': [
        { 'node': { 'topic': { 'name': 'Hacktoberfest' } } }
      ] }
    } },
  INVALID_LABEL_PR,
  { 'id' => 'MDExOlBdfsfafsfdsF1ZXN0OTA4ODAzMzQ=',
    'title' => 'Timeline Feature',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/intridea/hashie/pull/379',
    # This is valid, eligible
    'createdAt' => (Time.zone.parse(ENV['NOW_DATE']) - 19.days).to_s,
    'labels' => { 'edges' => [] },
    'merged' => true,
    'repository' => {
      'databaseId' => 123,
      'repositoryTopics' => { 'edges': [
        { 'node': { 'topic': { 'name': 'Hacktoberfest' } } }
      ] }
    } }
].freeze

# 5 pull requests with valid dates and valid labels
VALID_ARRAY = [
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NDc0Nzk5ODQ=',
    'title' => 'Results by cookie',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/peek/peek/pull/79',
    # This is valid, eligible
    'createdAt' => (Time.zone.parse(ENV['NOW_DATE']) - 15.days).to_s,
    'labels' => { 'edges' => [] },
    'merged' => true,
    'repository' => {
      'databaseId' => 123,
      'repositoryTopics' => { 'edges': [
        { 'node': { 'topic': { 'name': 'Hacktoberfest' } } }
      ] }
    } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NTE0MTg4ODg=',
    'title' => 'Update README.md',
    'body' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/vulume/Cordova-DBCamera/pull/1',
    # This is valid, eligible
    'createdAt' => (Time.zone.parse(ENV['NOW_DATE']) - 16.days).to_s,
    'labels' => { 'edges' => [] },
    'merged' => true,
    'repository' => {
      'databaseId' => 123,
      'repositoryTopics' => { 'edges': [
        { 'node': { 'topic': { 'name': 'Hacktoberfest' } } }
      ] }
    } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NjkyNjE4Mjk=',
    'title' => 'Add natural layer',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/syl20bnr/spacemacs/pull/6012',
    # This is valid, eligible
    'createdAt' => (Time.zone.parse(ENV['NOW_DATE']) - 17.days).to_s,
    'labels' => { 'edges': [{ 'node': { 'name': 'hacktoberfest-accepted' } }] },
    'repository' => {
      'databaseId' => 123,
      'repositoryTopics' => { 'edges': [
        { 'node': { 'topic': { 'name': 'Hacktoberfest' } } }
      ] }
    } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0OTA4ODAzMzQ=',
    'title' => 'Coercion type systems',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/intridea/hashie/pull/379',
    # This is valid, eligible
    'createdAt' => (Time.zone.parse(ENV['NOW_DATE']) - 18.days).to_s,
    'labels' => { 'edges' => [] },
    'merged' => true,
    'repository' => {
      'databaseId' => 123,
      'repositoryTopics' => { 'edges': [
        { 'node': { 'topic': { 'name': 'Hacktoberfest' } } }
      ] }
    } },
  { 'id' => 'MDExOlBdfsfafsfdsF1ZXN0OTA4ODAzMzQ=',
    'title' => 'Timeline Feature',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/intridea/hashie/pull/379',
    # This is valid, eligible
    'createdAt' => (Time.zone.parse(ENV['NOW_DATE']) - 19.days).to_s,
    'labels' => { 'edges': [{ 'node': { 'name': 'hacktoberfest-accepted' } }] },
    'repository' => {
      'databaseId' => 123,
      'repositoryTopics' => { 'edges' => [] }
    } }
].freeze

# 4 pull requests all with timestamps older than 14 days, eligible/mature
MATURE_ARRAY = [
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NDc0Nzk5ODQ=',
    'title' => 'Results by cookie',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/peek/peek/pull/79',
    'createdAt' => (Time.zone.parse(ENV['NOW_DATE']) - 15.days).to_s,
    'labels' => { 'edges' => [] },
    'merged' => true,
    'repository' => {
      'databaseId' => 123,
      'repositoryTopics' => { 'edges': [
        { 'node': { 'topic': { 'name': 'Hacktoberfest' } } }
      ] }
    } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NTE0MTg4ODg=',
    'title' => 'Update README.md',
    'body' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/vulume/Cordova-DBCamera/pull/1',
    'createdAt' => (Time.zone.parse(ENV['NOW_DATE']) - 16.days).to_s,
    'labels' => { 'edges': [{ 'node': { 'name': 'hacktoberfest-accepted' } }] },
    'repository' => {
      'databaseId' => 123,
      'repositoryTopics' => { 'edges': [
        { 'node': { 'topic': { 'name': 'Hacktoberfest' } } }
      ] }
    } },
  INVALID_LABEL_PR.merge('merged' => true),
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0OTA4ODAzMzQ=',
    'title' => 'Coercion type systems',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/intridea/hashie/pull/379',
    'createdAt' => (Time.zone.parse(ENV['NOW_DATE']) - 18.days).to_s,
    'labels' => { 'edges' => [] },
    'reviewDecision' => 'APPROVED',
    'repository' => {
      'databaseId' => 123,
      'repositoryTopics' => { 'edges': [
        { 'node': { 'topic': { 'name': 'Hacktoberfest' } } }
      ] }
    } }
].freeze

IMMATURE_PR = {
  'id' => 'MDExOlB1bGxSZXF1ZXN0NDc0Nzk5ODQ=',
  'title' => 'Results by cookie',
  'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
    tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
  'url' => 'https://github.com/peek/peek/pull/79',
  'createdAt' => (Time.zone.parse(ENV['NOW_DATE']) - 2.days).to_s,
  'labels' => { 'edges' => [] },
  'reviewDecision' => 'APPROVED',
  'repository' => {
    'databaseId' => 123,
    'repositoryTopics' => { 'edges': [
      { 'node': { 'topic': { 'name': 'Hacktoberfest' } } }
    ] }
  }
}.freeze

IMMATURE_INVALID_MERGED_PR = {
  'id' => 'MDExOlB1bGxSZXF1ZXN0NjkyNjE4Mjk=',
  'title' => 'Add natural layer',
  'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
    tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
  'url' => 'https://github.com/syl20bnr/spacemacs/pull/6012',
  'createdAt' => (Time.zone.parse(ENV['NOW_DATE']) - 2.days).to_s,
  # Invalid label should make it invalid
  'labels' => { 'edges': [{ 'node': { 'name': 'Invalid' } }] },
  # Merged should override the invalid label and make it valid
  'merged' => true,
  'repository' => {
    'databaseId' => 123,
    'repositoryTopics' => { 'edges': [
      { 'node': { 'topic': { 'name': 'Hacktoberfest' } } }
    ] }
  }
}.freeze

# 4 pull requests with timestamps less than 7 days old, maturing
IMMATURE_ARRAY = [
  IMMATURE_PR,
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NTE0MTg4ODg=',
    'title' => 'Update README.md',
    'body' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/vulume/Cordova-DBCamera/pull/1',
    'createdAt' => (Time.zone.parse(ENV['NOW_DATE']) - 3.days).to_s,
    'labels' => { 'edges' => [] },
    'merged' => true,
    'repository' => {
      'databaseId' => 123,
      'repositoryTopics' => { 'edges': [
        { 'node': { 'topic': { 'name': 'Hacktoberfest' } } }
      ] }
    } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NjkyNjE4Mjk=',
    'title' => 'Add natural layer',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/syl20bnr/spacemacs/pull/6012',
    'createdAt' => (Time.zone.parse(ENV['NOW_DATE']) - 4.days).to_s,
    'labels' => { 'edges' => [] },
    'reviewDecision' => 'APPROVED',
    'repository' => {
      'databaseId' => 123,
      'repositoryTopics' => { 'edges': [
        { 'node': { 'topic': { 'name': 'Hacktoberfest' } } }
      ] }
    } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0OTA4ODAzMzQ=',
    'title' => 'Coercion type systems',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/intridea/hashie/pull/379',
    'createdAt' => (Time.zone.parse(ENV['NOW_DATE']) - 5.days).to_s,
    'labels' => { 'edges': [{ 'node': { 'name': 'hacktoberfest-accepted' } }] },
    'repository' => {
      'databaseId' => 123,
      'repositoryTopics' => { 'edges': [
        { 'node': { 'topic': { 'name': 'Hacktoberfest' } } }
      ] }
    } }
].freeze

LARGE_IMMATURE_ARRAY = [
  { 'id' => 'MDExOlBdfsfafsfdsF1ZXN0OTA4ODAzMzQ=',
    'title' => 'Results by cookie',
    'body' =>
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
  eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/peek/peek/pull/79',
    'createdAt' => (Time.zone.parse(ENV['NOW_DATE']) - 1.day).to_s,
    'labels' => { 'edges': [{ 'node': { 'name': 'hacktoberfest-accepted' } }] },
    'repository' => {
      'databaseId' => 123,
      'repositoryTopics' => { 'edges': [
        { 'node': { 'topic': { 'name': 'Hacktoberfest' } } }
      ] }
    } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NDc0Nzk5ODQ=',
    'title' => 'Results by localstorage',
    'body' =>
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
  eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/peek/peek/pull/79',
    'createdAt' => (Time.zone.parse(ENV['NOW_DATE']) - 2.days).to_s,
    'labels' => { 'edges': [{ 'node': { 'name': 'hacktoberfest-accepted' } }] },
    'repository' => {
      'databaseId' => 123,
      'repositoryTopics' => { 'edges' => [] }
    } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NTE0MTg4ODg=',
    'title' => 'Update README.md',
    'body' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
  eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/vulume/Cordova-DBCamera/pull/1',
    'createdAt' => (Time.zone.parse(ENV['NOW_DATE']) - 3.days).to_s,
    'labels' => { 'edges' => [] },
    'merged' => true,
    'repository' => {
      'databaseId' => 123,
      'repositoryTopics' => { 'edges': [
        { 'node': { 'topic': { 'name': 'Hacktoberfest' } } }
      ] }
    } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NjkyNjE4Mjk=',
    'title' => 'Add natural layer',
    'body' =>
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
  eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/syl20bnr/spacemacs/pull/6012',
    'createdAt' => (Time.zone.parse(ENV['NOW_DATE']) - 4.days).to_s,
    'labels' => { 'edges' => [] },
    'merged' => true,
    'repository' => {
      'databaseId' => 123,
      'repositoryTopics' => { 'edges': [
        { 'node': { 'topic': { 'name': 'Hacktoberfest' } } }
      ] }
    } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0OTA4ODAzMzQ=',
    'title' => 'Coercion type systems',
    'body' =>
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
  eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/intridea/hashie/pull/379',
    'createdAt' => (Time.zone.parse(ENV['NOW_DATE']) - 5.days).to_s,
    'labels' => { 'edges' => [] },
    'merged' => true,
    'repository' => {
      'databaseId' => 123,
      'repositoryTopics' => { 'edges': [
        { 'node': { 'topic': { 'name': 'Hacktoberfest' } } }
      ] }
    } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0OTA4ODAzMzQB1bG=',
    'title' => 'Timeline Feature',
    'body' =>
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
  eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/intridea/hashie/pull/546',
    'createdAt' => (Time.zone.parse(ENV['NOW_DATE']) - 6.days).to_s,
    'labels' => { 'edges' => [] },
    'reviewDecision' => 'APPROVED',
    'repository' => {
      'databaseId' => 123,
      'repositoryTopics' => { 'edges': [
        { 'node': { 'topic': { 'name': 'Hacktoberfest' } } }
      ] }
    } }
].freeze

# 4 pull requests with timestamps less than 7 days before the end
LATE_ARRAY = [
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NDc0Nzk5ODQ=',
    'title' => 'Results by cookie',
    'body' =>
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
  eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/peek/peek/pull/79',
    'createdAt' => (Time.zone.parse(ENV['END_DATE']) - 2.days).to_s,
    'labels' => { 'edges' => [] },
    'reviewDecision' => 'APPROVED',
    'repository' => {
      'databaseId' => 123,
      'repositoryTopics' => { 'edges': [
        { 'node': { 'topic': { 'name': 'Hacktoberfest' } } }
      ] }
    } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NTE0MTg4ODg=',
    'title' => 'Update README.md',
    'body' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
  eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/vulume/Cordova-DBCamera/pull/1',
    'createdAt' => (Time.zone.parse(ENV['END_DATE']) - 3.days).to_s,
    'labels' => { 'edges' => [] },
    'merged' => true,
    'repository' => {
      'databaseId' => 123,
      'repositoryTopics' => { 'edges': [
        { 'node': { 'topic': { 'name': 'Hacktoberfest' } } }
      ] }
    } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NjkyNjE4Mjk=',
    'title' => 'Add natural layer',
    'body' =>
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
  eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/syl20bnr/spacemacs/pull/6012',
    'createdAt' => (Time.zone.parse(ENV['END_DATE']) - 4.days).to_s,
    'labels' => { 'edges' => [] },
    'merged' => true,
    'repository' => {
      'databaseId' => 123,
      'repositoryTopics' => { 'edges': [
        { 'node': { 'topic': { 'name': 'Hacktoberfest' } } }
      ] }
    } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0OTA4ODAzMzQ=',
    'title' => 'Coercion type systems',
    'body' =>
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
  eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/intridea/hashie/pull/379',
    'createdAt' => (Time.zone.parse(ENV['END_DATE']) - 5.days).to_s,
    'labels' => { 'edges' => [] },
    'merged' => true,
    'repository' => {
      'databaseId' => 123,
      'repositoryTopics' => { 'edges': [
        { 'node': { 'topic': { 'name': 'Hacktoberfest' } } }
      ] }
    } }
].freeze

MIXED_MATURITY_ARRAY = IMMATURE_ARRAY[0..1] + MATURE_ARRAY[2..3]

PR_DATA = {
  valid_array: VALID_ARRAY,
  array_with_invalid_labels: ARRAY_WITH_INVALID_LABEL,
  array_with_invalid_dates: ARRAY_WITH_INVALID_DATES,
  invalid_array: ARRAY_WITH_INVALID_DATES_AND_INVALID_LABEL,
  mature_array: MATURE_ARRAY,
  immature_array: IMMATURE_ARRAY,
  large_immature_array: LARGE_IMMATURE_ARRAY,
  mixed_maturity_array: MIXED_MATURITY_ARRAY,
  late_array: LATE_ARRAY
}.freeze

module PullRequestFilterHelper
  include RSpec::Mocks::ExampleMethods

  def pull_request_data(pr_array)
    pr_array.map do |hash|
      github_pull_request(hash)
    end
  end

  def github_pull_request(hash)
    GithubPullRequest.new(Hashie::Mash.new(hash))
  end

  def pr_stub_helper(target, pr_data, clear = true)
    PullRequest.delete_all if clear
    allow(target.send(:pull_request_service))
      .to receive(:github_pull_requests)
      .and_return(pull_request_data(pr_data))
  end

  class << self
    include PullRequestFilterHelper
  end
end
