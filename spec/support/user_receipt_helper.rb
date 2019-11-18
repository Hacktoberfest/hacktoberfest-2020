# frozen_string_literal: true

EARLY_RECEIPT_3_PRS = [
  { 'github_pull_request' =>
    { 'graphql_hash' =>
      { 'id' => 'MDExOlB1bGxSZXF1ZXN0MzI1NDc3OTA3',
        'url' => 'https://github.com/hacktoberfest-test/pull/18',
        'body' => '',
        'title' => 'Peculiar bug',
        'labels' => { 'edges' => [] },
        'createdAt' => '2019-10-07T20:23:23Z',
        'repository' => { 'databaseId' => 211_178_535 } } } },
  { 'github_pull_request' =>
    { 'graphql_hash' =>
      { 'id' => 'MDExOlB1bGxSZXF1ZXN0MzI1NDc4MDIy',
        'url' => 'https://github.com/20',
        'body' => '',
        'title' => 'CI scripts',
        'labels' => { 'edges' => [] },
        'createdAt' => '2019-10-09T20:23:42Z',
        'repository' => { 'databaseId' => 211_178_535 } } } },
  { 'github_pull_request' =>
    { 'graphql_hash' =>
      { 'id' => 'MDExOlB1bGxSZXF1ZXN0MzI1NDc4MDc2',
        'url' => 'https://github.com/21',
        'body' => '',
        'title' => 'readme addition',
        'labels' => { 'edges' => [] },
        'createdAt' => '2019-10-08T20:23:51Z',
        'repository' => { 'databaseId' => 211_178_535 } } } }
].freeze

EARLY_RECEIPT_2_PRS = [
  { 'github_pull_request' =>
    { 'graphql_hash' =>
      { 'id' => 'MDExOlB1bGxSZXF1ZXN0MzI1NDc3OTA3',
        'url' => 'https://github.com/18',
        'body' => '',
        'title' => 'Peculiar bug',
        'labels' => { 'edges' => [] },
        'createdAt' => '2019-10-07T20:23:23Z',
        'repository' => { 'databaseId' => 211_178_535 } } } },
  { 'github_pull_request' =>
    { 'graphql_hash' =>
      { 'id' => 'MDExOlB1bGxSZXF1ZXN0MzI1NDc4MDIy',
        'url' => 'https://github.com/20',
        'body' => '',
        'title' => 'CI scripts',
        'labels' => { 'edges' => [] },
        'createdAt' => '2019-10-10T20:23:42Z',
        'repository' => { 'databaseId' => 211_178_535 } } } }
].freeze

LATE_RECEIPT_2_PRS = [
  { 'github_pull_request' =>
    { 'graphql_hash' =>
      { 'id' => 'MDExOlB1bGxSZXF1ZXN0MzI1NDc3OTA3',
        'url' => 'https://github.com/18',
        'body' => '',
        'title' => 'Peculiar bug',
        'labels' => { 'edges' => [] },
        'createdAt' => '2019-10-27T20:23:23Z',
        'repository' => { 'databaseId' => 211_178_535 } } } },
  { 'github_pull_request' =>
    { 'graphql_hash' =>
      { 'id' => 'MDExOlB1bGxSZXF1ZXN0MzI1NDc4MDIy',
        'url' => 'https://github.com',
        'body' => '',
        'title' => 'CI scripts',
        'labels' => { 'edges' => [] },
        'createdAt' => '2019-10-29T20:23:42Z',
        'repository' => { 'databaseId' => 211_178_535 } } } }
].freeze

LATE_RECEIPT_3_PRS = [
  { 'github_pull_request' =>
    { 'graphql_hash' =>
      { 'id' => 'MDExOlB1bGxSZXF1ZXN0MzI1NDc3OTA3',
        'url' => 'https://github.com/18',
        'body' => '',
        'title' => 'Peculiar bug',
        'labels' => { 'edges' => [] },
        'createdAt' => '2019-10-30T20:23:23Z',
        'repository' => { 'databaseId' => 211_178_535 } } } },
  { 'github_pull_request' =>
    { 'graphql_hash' =>
      { 'id' => 'MDExOlB1bGxSZXF1ZXN0MzI1NDc4MDIy',
        'url' => 'https://github.com/20',
        'body' => '',
        'title' => 'CI scripts',
        'labels' => { 'edges' => [] },
        'createdAt' => '2019-10-20T20:23:42Z',
        'repository' => { 'databaseId' => 211_178_535 } } } },
  { 'github_pull_request' =>
    { 'graphql_hash' =>
      { 'id' => 'MDExOlB1bGxSZXF1ZXN0MzI1NDc4MDc2',
        'url' => 'https://github.com/21',
        'body' => '',
        'title' => 'readme addition',
        'labels' => { 'edges' => [] },
        'createdAt' => '2019-10-28T20:23:51Z',
        'repository' => { 'databaseId' => 211_178_535 } } } }
].freeze

RECEIPT_DATA = {
  late_receipt_2_prs: LATE_RECEIPT_2_PRS,
  late_receipt_3_prs: LATE_RECEIPT_3_PRS,
  early_receipt_2_prs: EARLY_RECEIPT_2_PRS,
  early_receipt_3_prs: EARLY_RECEIPT_3_PRS
}.freeze

module UserReceiptHelper
  def self.receipt
    RECEIPT_DATA
  end
end
