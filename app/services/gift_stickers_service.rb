# frozen_string_literal: true

module GiftStickersService
  module_function

  def call
    user_dates = []

    User.where(state: 'incompleted').find_in_batches do |group|
      group.each do |u|
        date = u.receipt.min_by do |receipt|
          Time.zone.parse(
            receipt['github_pull_request']['graphql_hash']['createdAt']
          )
        end['github_pull_request']['graphql_hash']['createdAt']
        score = u.receipt.count
        user_dates << { id: u.id, score: score, date: date }
      end
    end

    sorted = user_dates.sort do |a, b|
      a_date = Time.zone.parse(a[:date])
      b_date = Time.zone.parse(b[:date])

      [b[:score], a_date] <=> [a[:score], b_date]
    end

    sorted.each do |user_date|
      u = User.find(user_date[:id])
      u.gift
    end
  end
end
