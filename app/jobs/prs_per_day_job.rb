# frozen_string_literal: true

class PrsPerDayJob
  include Sidekiq::Worker
  sidekiq_options queue: :default, retry: 7

  def perform(pr_stat_id)
    pr_stat = PRStat.find(pr_stat_id)

    PrsPerDayService.call(pr_stat)
  end
end
