# frozen_string_literal: true

class AllPrsPerDayJob
  include Sidekiq::Worker
  sidekiq_options queue: :default, retry: 3

  def perform
    DailyPRCount.destroy_all

    PRStat.select(:id).find_in_batches do |group|
      group.each { |pr_stat| PrsPerDayJob.perform_async(pr_stat.id) }
    end
  end
end
