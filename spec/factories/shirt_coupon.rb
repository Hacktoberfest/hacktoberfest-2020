# frozen_string_literal: true

FactoryBot.define do
  factory :shirt_coupon do
    sequence(:code) { |n| n }
  end
end
