# frozen_string_literal: true

class Language < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
