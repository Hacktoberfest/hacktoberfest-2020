# frozen_string_literal: true

module PrsPerDayService
  module_function

  def call(pr_stat)
    date = pr_stat.data["github_pull_request"]["graphql_hash"]["createdAt"]

    stat = DailyPRCount.where(date: Date.parse(date)).first_or_create()
    stat.count += 1
    
    stat.save
  end
end
