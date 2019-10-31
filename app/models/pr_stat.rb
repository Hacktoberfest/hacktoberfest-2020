# frozen_string_literal: true

class PRStat < ApplicationRecord
  validates :data, presence: true
  validates :pr_id, presence: true, uniqueness: true
end
