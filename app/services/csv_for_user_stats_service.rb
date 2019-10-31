# frozen_string_literal: true

require 'csv'

module CsvForUserStatsService
  module_function

  def call
    CSV.open("users.csv", "w") do |csv|
      # for headers
      csv << UserStat.last.data.keys

      # now for the rows
      UserStat.find_in_batches do |group|
        group.each do |user_stat|
          csv << user_stat.data.values
        end
      end
    end
  end
end
