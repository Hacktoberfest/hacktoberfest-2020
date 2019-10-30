# frozen_string_literal: true

module CountDailyPrsService
  module_function

  def call
    results = {}

    PRStat.find_in_batches do |group|
      group.each do |pr_stat|
        date = Date.parse(
          pr_stat.data['github_pull_request']['graphql_hash']['createdAt']
        )

        if results[date.to_s].nil?
          results[date.to_s] = 1
        else
          results[date.to_s] += 1
        end
      end
    end

    results
  end
end
