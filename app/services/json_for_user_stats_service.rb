# frozen_string_literal: true

require 'json'

module JsonForUserStatsService
  module_function

  def call
    File.open('users.json', 'w') do |f|
      f.write('[')
      UserStat.find_in_batches.with_index do |group, batch|
        group.each_with_index do |user_stat, index|
          f.write(',') unless batch.zero? && index.zero?

          f.write(JSON.pretty_generate(user_stat.data))
        end
      end
      f.write(']')
    end
  end
end
