# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name               { 'Testerson McTest' }
    email              { 'test@mail.com' }
    uid                { rand(1..1_000_000) }
    provider_token     { user_github_token }
    terms_acceptance   { true }

    trait :unregistered do
      terms_acceptance { false }
    end
  end
end
