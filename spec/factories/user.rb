# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'Testerson McTest' }
    email { 'test@mail.com' }
    uid { 405_106_69 }
    provider_token { ENV['GITHUB_ACCESS_TOKEN'] }
    terms_acceptance { true }
    state { 'registered' }

    trait :unregistered do
      terms_acceptance { false }
      state { 'new' }
    end

    trait :no_email do
      email { nil }
    end
  end
end
