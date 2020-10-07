# frozen_string_literal: true

namespace :users do
  desc 'Backfill all existing users for acceptance'
  task backfill_acceptance: :environment do
    User.where.not(state: 'new').find_each do |user|
      user.quality_acceptance = true
      user.disqualify_acceptance = true

      begin
        user.save!
      rescue StandardError => e
        # Log any errors to catch any broken users
        p user
        p e
      end
    end
  end

  desc 'Forcefully backfill all existing users for acceptance'
  task force_backfill_acceptance: :environment do
    User.where.not(state: 'new').find_each do |user|
      user.quality_acceptance = true
      user.disqualify_acceptance = true
      # Skip validation, just set it for everyone
      user.save!(validate: false)
    end
  end
end
