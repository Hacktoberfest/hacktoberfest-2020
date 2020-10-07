# frozen_string_literal: true

namespace :users do
  desc 'Backfill all existing users for acceptance'
  task backfill_acceptance: :environment do
    User.where.not(state: 'new').find_each do |user|
      user.quality_acceptance = true
      user.disqualify_acceptance = true

      # Fail-fast: if this errors,
      #  we have a broken user and should know about it
      user.save!
    end
  end
end
