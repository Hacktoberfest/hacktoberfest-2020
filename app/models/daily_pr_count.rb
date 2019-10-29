# frozen_string_literal: true

class DailyPRCount < ApplicationRecord
  validates :count, presence: true
  validates :date, presence: true, uniqueness: true
end
