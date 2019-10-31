# frozen_string_literal: true

FactoryBot.define do
  factory :spam_repository do
    sequence(:github_id) { |n| n }
  end
end
