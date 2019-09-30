# frozen_string_literal: true

FactoryBot.define do
  factory :sticker_coupon do
    sequence(:code) { |n| n }

    trait :consumed do
      association :user, factory: [:user, :won_sticker]
    end
  end
end
