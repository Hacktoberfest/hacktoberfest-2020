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
    'repository' => { 'databaseId' => 123 } }
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
    'labels' => { 'edges' => [{ 'node': { 'name': 'Invalid' } }] },
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
    'labels' => { 'edges': [{ 'node': { 'name': 'Invalid' } }] },
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
    'labels' => { 'edges' => [] } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NTE0MTg4ODg=',
    'title' => 'Update README.md',
    'body' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/vulume/Cordova-DBCamera/pull/1',
    'createdAt' => '2019-10-11T22:49:53Z',
    'labels' => { 'edges' => [] } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NjkyNjE4Mjk=',
    'title' => 'Add natural layer',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/syl20bnr/spacemacs/pull/6012',
    'createdAt' => '2019-10-08T06:24:38Z',
    'labels' => { 'edges' => [] } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0OTA4ODAzMzQ=',
    'title' => 'Coercion type systems',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/intridea/hashie/pull/379',
    'createdAt' => '2019-10-03T19:59:18Z',
    'labels' => { 'edges' => [] } }
].freeze

IMMATURE_ARRAY = [
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NDc0Nzk5ODQ=',
    'title' => 'Results by cookie',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/peek/peek/pull/79',
    'createdAt' => '2019-10-20T00:46:43Z',
    'labels' => { 'edges' => [] } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NTE0MTg4ODg=',
    'title' => 'Update README.md',
    'body' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/vulume/Cordova-DBCamera/pull/1',
    'createdAt' => '2019-10-18T22:49:53Z',
    'labels' => { 'edges' => [] } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0NjkyNjE4Mjk=',
    'title' => 'Add natural layer',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/syl20bnr/spacemacs/pull/6012',
    'createdAt' => '2019-10-17T06:24:38Z',
    'labels' => { 'edges' => [] } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0OTA4ODAzMzQ=',
    'title' => 'Coercion type systems',
    'body' =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
    'url' => 'https://github.com/intridea/hashie/pull/379',
    'createdAt' => '2019-10-19T19:59:18Z',
    'labels' => { 'edges' => [] } }
].freeze

ARRAY_FOR_RECEIPT_LOGIC = [
  {'id'=>'MDExOlB1bGxSZXF1ZXN0MzI1NDc3OTA3',
   'url'=>'https://github.com/raise-dev/hacktoberfest-test/pull/18',
   'body'=>'',
   'title'=>'Peculiar branch',
   'labels'=>{'edges'=>[]},
   'createdAt'=>'2019-10-07T20:23:23Z',
   'repository'=>{'databaseId'=>211178535}},
   {'id'=>'MDExOlB1bGxSZXF1ZXN0MzI1NDc3OTY1',
   'url'=>'https://github.com/raise-dev/hacktoberfest-test/pull/19',
   'body'=>'',
   'title'=>'Fun branch',
   'labels'=>{'edges'=>[]},
   'createdAt'=>'2019-10-07T20:23:33Z',
   'repository'=>{'databaseId'=>211178535}},
   {'id'=>'MDExOlB1bGxSZXF1ZXN0MzI1NDc4MDIy',
   'url'=>'https://github.com/raise-dev/hacktoberfest-test/pull/20',
   'body'=>'',
   'title'=>'Super branch',
   'labels'=>{'edges'=>[]},
   'createdAt'=>'2019-10-07T20:23:42Z',
   'repository'=>{'databaseId'=>211178535}},
   {'id'=>'MDExOlB1bGxSZXF1ZXN0MzI1NDc4MDc2',
   'url'=>'https://github.com/raise-dev/hacktoberfest-test/pull/21',
   'body'=>'',
   'title'=>'readme addition',
   'labels'=>{'edges'=>[]},
   'createdAt'=>'2019-10-07T20:23:51Z',
   'repository'=>{'databaseId'=>211178535}},
   {'id'=>'MDExOlB1bGxSZXF1ZXN0MzI1NDgxMzA4',
   'url'=>'https://github.com/raise-dev/hacktoberfest-test/pull/22',
   'body'=>'',
   'title'=>'Fakerson',
   'labels'=>{'edges'=>[{'node'=>{'name'=>'invalid'}}]},
   'createdAt'=>'2019-10-07T20:32:11Z',
   'repository'=>{'databaseId'=>211178535}},
   {'id' => 'MDExOlB1bGxSZXF1ZXN0NDc0Nzk5ODQ=',
   'title' => 'Results by cookie',
   'body' =>
   'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
   eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
   'url' => 'https://github.com/peek/peek/pull/79',
   'createdAt' => '2019-10-11T00:46:43Z',
   'labels' => { 'edges' => [] } },
   {'id' => 'MDExOlB1bGxSZXF1ZXN0NTE0MTg4ODg=',
   'title' => 'Update README.md',
   'body' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
   eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim.',
   'url' => 'https://github.com/vulume/Cordova-DBCamera/pull/1',
   'createdAt' => '2019-10-11T22:49:53Z',
   'labels' => { 'edges' => [] } }
].freeze

MIXED_MATURITY_ARRAY = IMMATURE_ARRAY[0..1] + MATURE_ARRAY[2..3]

PR_DATA = {
  valid_array: VALID_ARRAY,
  array_with_invalid_labels: ARRAY_WITH_INVALID_LABEL,
  array_with_invalid_dates: ARRAY_WITH_INVALID_DATES,
  invalid_array: ARRAY_WITH_INVALID_DATES_AND_INVALID_LABEL,
  mature_array: MATURE_ARRAY,
  immature_array: IMMATURE_ARRAY,
  mixed_maturity_array: MIXED_MATURITY_ARRAY,
  array_for_receipt_logic: ARRAY_FOR_RECEIPT_LOGIC
}.freeze

module PullRequestFilterHelper
  def pull_request_data(pr_array)
    pr_array.map do |hash|
      GithubPullRequest.new(Hashie::Mash.new(hash))
    end
  end
end
