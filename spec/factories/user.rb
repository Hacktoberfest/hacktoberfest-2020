# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name              { 'Testerson McTest' }
    email             { 'test@mail.com' }
    uid               { rand(1..1_000_000) }
    provider_token    { user_github_token }
    terms_acceptance  { false }
    state             { 'new' }

    trait :registered do
      terms_acceptance { true }
      state { 'registered' }
    end

    trait :no_email do
      email { nil }
    end
  end
end
