# frozen_string_literal: true

namespace :users do
  desc 'Backfill missing receipts for completed users'
  task backfill_receipts: :environment do
    BackfillMissingReceiptsService.call
  end
end
