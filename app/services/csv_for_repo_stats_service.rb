# frozen_string_literal: true

require 'csv'

module CsvForUserStatsService
  module_function

  def call
    CSV.open("repos.csv", "w") do |csv|
      # for headers
      csv << RepoStat.last.data.keys

      # now for the rows
      RepoStat.find_in_batches do |group|
        group.each do |repo_stat|
          csv << user_stat.data.values
        end
      end
    end
  end
end
