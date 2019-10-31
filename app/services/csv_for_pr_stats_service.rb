# frozen_string_literal: true

require 'csv'

module CsvForPrStatsService
  module_function

  def call
    CSV.open("prs.csv", "w") do |csv|
      # for headers
      csv << [
        'id',
        'repo_id',
        'title',
        'body',
        'url',
        'created_at',
        'name',
        'owner',
        'label1',
        'label2',
        'label3',
        'label4'
      ]

      # now for the rows
      PRStat.find_in_batches do |group|
        group.each do |pr_stat|
          pr_hash = Hashie::Mash.new(pr_stat.data).github_pull_request.graphql_hash
          pr = GithubPullRequest.new(pr_hash)

          val_array = []

          val_array << pr.id
          val_array << pr.repo_id 
          val_array << pr.title
          val_array << pr.body
          val_array << pr.url
          val_array << pr.created_at
          val_array << pr.name
          val_array << pr.owner

          pr.label_names.each do |label_name|
            val_array << label_name
          end

          csv << val_array
        end
      end
    end
  end
end
