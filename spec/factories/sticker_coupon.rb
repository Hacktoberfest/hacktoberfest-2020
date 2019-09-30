# frozen_string_literal: true

FactoryBot.define do
  factory :sticker_coupon do
    sequence(:code) { |n| n }
  end
end
