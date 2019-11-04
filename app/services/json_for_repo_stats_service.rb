# frozen_string_literal: true

require 'json'

module JsonForRepoStatsService
  module_function

  def call
    File.open('repositories.json', 'w') do |f|
      f.write('[')
      RepoStat.find_in_batches.with_index do |group, batch|
        group.each_with_index do |repo_stat, index|
          # unless first repo, prepend a comma
          f.write(',') unless batch.zero? && index.zero?

          f.write(JSON.pretty_generate(repo_stat.data))
        end
      end
      f.write(']')
    end
  end
end
