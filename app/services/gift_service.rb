# frozen_string_literal: true

module GiftService
  module_function

  def call
    user_dates = []

    User.where(state: 'incompleted').find_in_batches do |group|
      group.each do |u|
        last_pr = u.receipt.max_by do |pr_obj|
          Time.zone.parse(
            pr_obj['createdAt']
          )
        end
        date = last_pr['createdAt']
        score = u.receipt.count
        user_dates << { id: u.id, score: score, date: date }
      end
    end

    sorted = user_dates.sort do |a, b|
      a_date = Time.zone.parse(a[:date])
      b_date = Time.zone.parse(b[:date])

      # This comparison will prioritize first the score of the objects and then
      # their dates.
      [b[:score], a_date] <=> [a[:score], b_date]
    end

    sorted.each do |user_date|
      u = User.find(user_date[:id])
      u.gift
    end
  end
end
