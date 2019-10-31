# frozen_string_literal: true

require 'csv'

module CsvForPrStatsService
  module_function

  def call
    CSV.open("prs.csv", "w") do |csv|
      # for headers
      csv << PRStat.last.data["github_pull_request"]["graphql_hash"].keys

      # now for the rows
      PRStat.find_in_batches do |group|
        group.each do |pr_stat|
          csv << pr_stat.data["github_pull_request"]["graphql_hash"].values
        end
      end
    end
  end
end
