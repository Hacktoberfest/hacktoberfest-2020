# frozen_string_literal: true

EARLY_RECEIPT_3_PRS = [
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0MzI1NDc3OTA3',
    'url' => 'https://github.com/hacktoberfest-test/pull/18',
    'body' => '',
    'title' => 'Peculiar bug',
    'labels' => { 'edges' => [] },
    'createdAt' => (Time.zone.parse(ENV['START_DATE']) + 7.days).to_s,
    'repository' => { 'databaseId' => 211_178_535 } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0MzI1NDc4MDIy',
    'url' => 'https://github.com/20',
    'body' => '',
    'title' => 'CI scripts',
    'labels' => { 'edges' => [] },
    'createdAt' => (Time.zone.parse(ENV['START_DATE']) + 9.days).to_s,
    'repository' => { 'databaseId' => 211_178_535 } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0MzI1NDc4MDc2',
    'url' => 'https://github.com/21',
    'body' => '',
    'title' => 'readme addition',
    'labels' => { 'edges' => [] },
    'createdAt' => (Time.zone.parse(ENV['START_DATE']) + 8.days).to_s,
    'repository' => { 'databaseId' => 211_178_535 } }
].freeze

EARLY_RECEIPT_2_PRS = [
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0MzI1NDc3OTA3',
    'url' => 'https://github.com/18',
    'body' => '',
    'title' => 'Peculiar bug',
    'labels' => { 'edges' => [] },
    'createdAt' => (Time.zone.parse(ENV['START_DATE']) + 7.days).to_s,
    'repository' => { 'databaseId' => 211_178_535 } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0MzI1NDc4MDIy',
    'url' => 'https://github.com/20',
    'body' => '',
    'title' => 'CI scripts',
    'labels' => { 'edges' => [] },
    'createdAt' => (Time.zone.parse(ENV['START_DATE']) + 10.days).to_s,
    'repository' => { 'databaseId' => 211_178_535 } }
].freeze

LATE_RECEIPT_2_PRS = [
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0MzI1NDc3OTA3',
    'url' => 'https://github.com/18',
    'body' => '',
    'title' => 'Peculiar bug',
    'labels' => { 'edges' => [] },
    'createdAt' => (Time.zone.parse(ENV['END_DATE']) - 3.days).to_s,
    'repository' => { 'databaseId' => 211_178_535 } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0MzI1NDc4MDIy',
    'url' => 'https://github.com',
    'body' => '',
    'title' => 'CI scripts',
    'labels' => { 'edges' => [] },
    'createdAt' => (Time.zone.parse(ENV['END_DATE']) - 2.days).to_s,
    'repository' => { 'databaseId' => 211_178_535 } }
].freeze

LATE_RECEIPT_3_PRS = [
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0MzI1NDc3OTA3',
    'url' => 'https://github.com/18',
    'body' => '',
    'title' => 'Peculiar bug',
    'labels' => { 'edges' => [] },
    'createdAt' => (Time.zone.parse(ENV['END_DATE']) - 1.day).to_s,
    'repository' => { 'databaseId' => 211_178_535 } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0MzI1NDc4MDIy',
    'url' => 'https://github.com/20',
    'body' => '',
    'title' => 'CI scripts',
    'labels' => { 'edges' => [] },
    'createdAt' => (Time.zone.parse(ENV['END_DATE']) - 4.days).to_s,
    'repository' => { 'databaseId' => 211_178_535 } },
  { 'id' => 'MDExOlB1bGxSZXF1ZXN0MzI1NDc4MDc2',
    'url' => 'https://github.com/21',
    'body' => '',
    'title' => 'readme addition',
    'labels' => { 'edges' => [] },
    'createdAt' => (Time.zone.parse(ENV['END_DATE']) - 3.days).to_s,
    'repository' => { 'databaseId' => 211_178_535 } }
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
