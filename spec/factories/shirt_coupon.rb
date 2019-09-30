# frozen_string_literal: true

FactoryBot.define do
  factory :shirt_coupon do
    sequence(:code) { |n| n }

    trait :consumed do
      association :user, factory: [:user, :won_shirt]
    end
  end
end
