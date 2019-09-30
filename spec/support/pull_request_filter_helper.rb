# frozen_string_literal: true

ARRAY_WITH_INVALID_DATES = [
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NDc0Nzk5ODQ=',
    'title' => 'Results by cookie',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/peek/peek/pull/79',
    'createdAt' => '2015-10-13T00:46:43Z',
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NTE0MTg4ODg=',
    'title' => 'Update README.md',
    'body' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/vulume/Cordova-DBCamera/pull/1',
    'createdAt' => '2015-11-20T22:49:53Z',
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 }  },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NjkyNjE4Mjk=',
    'title' => 'Add natural layer',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/syl20bnr/spacemacs/pull/6012',
    'createdAt' => '2019-10-08T06:24:38Z',
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 }  },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0OTA4ODAzMzQ=',
    'title' => 'Coercion type systems',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/intridea/hashie/pull/379',
    'createdAt' => '2019-10-25T19:59:18Z',
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 }  }
].freeze

ARRAY_WITH_INVALID_DATES_AND_INVALID_LABEL = [
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NDc0Nzk5ODQ=',
    'title' => 'Results by cookie',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/peek/peek/pull/79',
    'createdAt' => '2015-10-13T00:46:43Z',
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NTE0MTg4ODg=',
    'title' => 'Update README.md',
    'body' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/vulume/Cordova-DBCamera/pull/1',
    'createdAt' => '2015-11-20T22:49:53Z',
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NjkyNjE4Mjk=',
    'title' => 'Add natural layer',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/syl20bnr/spacemacs/pull/6012',
    'createdAt' => '2016-05-08T06:24:38Z',
    'labels' => { 'edges': [{ 'node': { 'name': 'Invalid' } }] },
    'repository' => { 'databaseId' => 123 } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0OTA4ODAzMzQ=',
    'title' => 'Coercion type systems',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/intridea/hashie/pull/379',
    'createdAt' => '2016-10-25T19:59:18Z',
    'labels' => { 'edges': [{ 'node': { 'name': 'Invalid' } }] },
    'repository' => { 'databaseId' => 123 } }
].freeze

ARRAY_WITH_INVALID_LABEL = [
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NDc0Nzk5ODQ=',
    'title' => 'Results by cookie',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/peek/peek/pull/79',
    'createdAt' => '2019-10-13T00:46:43Z',
    'labels' => { 'edges' => [{ 'node': { 'name': 'Invalid' } }] } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NTE0MTg4ODg=',
    'title' => 'Update README.md',
    'body' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/vulume/Cordova-DBCamera/pull/1',
    'createdAt' => '2019-10-20T22:49:53Z',
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 } } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NjkyNjE4Mjk=',
    'title' => 'Add natural layer',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/syl20bnr/spacemacs/pull/6012',
    'createdAt' => '2019-10-08T06:24:38Z',
    'labels' => { 'edges': [] } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0OTA4ODAzMzQ=',
    'title' => 'Coercion type systems',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/intridea/hashie/pull/379',
    'createdAt' => '2019-10-25T19:59:18Z',
    'labels' => { 'edges': [{ 'node': { 'name': 'Invalid' } }] } },
  { 'id' => 'MDExOlBdfsfafsfdsF1ZXN0OTA4ODAzMzQ=',
    'title' => 'Timeline Feature',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/intridea/hashie/pull/379',
    'createdAt' => '2019-10-28T19:59:18Z',
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 } } }
].freeze

VALID_ARRAY = [
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NDc0Nzk5ODQ=',
    'title' => 'Results by cookie',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/peek/peek/pull/79',
    'createdAt' => '2019-10-13T00:46:43Z',
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NTE0MTg4ODg=',
    'title' => 'Update README.md',
    'body' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/vulume/Cordova-DBCamera/pull/1',
    'createdAt' => '2019-10-20T22:49:53Z',
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NjkyNjE4Mjk=',
    'title' => 'Add natural layer',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/syl20bnr/spacemacs/pull/6012',
    'createdAt' => '2019-10-08T06:24:38Z',
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0OTA4ODAzMzQ=',
    'title' => 'Coercion type systems',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/intridea/hashie/pull/379',
    'createdAt' => '2019-10-25T19:59:18Z',
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 } },
  { 'id' => 'MDExOlBdfsfafsfdsF1ZXN0OTA4ODAzMzQ=',
    'title' => 'Timeline Feature',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/intridea/hashie/pull/379',
    'createdAt' => '2019-10-28T19:59:18Z',
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 } }
].freeze

MATURE_ARRAY = [
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NDc0Nzk5ODQ=',
    'title' => 'Results by cookie',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/peek/peek/pull/79',
    'createdAt' => '2019-10-11T00:46:43Z',
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 } } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NTE0MTg4ODg=',
    'title' => 'Update README.md',
    'body' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/vulume/Cordova-DBCamera/pull/1',
    'createdAt' => '2019-10-11T22:49:53Z',
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 } } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NjkyNjE4Mjk=',
    'title' => 'Add natural layer',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/syl20bnr/spacemacs/pull/6012',
    'createdAt' => '2019-10-08T06:24:38Z',
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 } } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0OTA4ODAzMzQ=',
    'title' => 'Coercion type systems',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/intridea/hashie/pull/379',
    'createdAt' => '2019-10-03T19:59:18Z',
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 } } }
].freeze

IMMATURE_ARRAY = [
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NDc0Nzk5ODQ=',
    'title' => 'Results by cookie',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/peek/peek/pull/79',
    'createdAt' => '2019-10-20T00:46:43Z',
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 } } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NTE0MTg4ODg=',
    'title' => 'Update README.md',
    'body' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/vulume/Cordova-DBCamera/pull/1',
    'createdAt' => '2019-10-18T22:49:53Z',
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 } } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NjkyNjE4Mjk=',
    'title' => 'Add natural layer',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/syl20bnr/spacemacs/pull/6012',
    'createdAt' => '2019-10-17T06:24:38Z',
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 } } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0OTA4ODAzMzQ=',
    'title' => 'Coercion type systems',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/intridea/hashie/pull/379',
    'createdAt' => '2019-10-19T19:59:18Z',
    'labels' => { 'edges' => [] },
    'repository' => { 'databaseId' => 123 } } }
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
end
