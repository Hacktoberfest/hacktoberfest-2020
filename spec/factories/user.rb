# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name              { 'Testerson McTest' }
    email             { 'test@mail.com' }
    uid               { rand(1..1_000_000) }
    provider_token    { user_github_token }
    terms_acceptance  { true }
    state             { 'registered' }

    trait :new do
      terms_acceptance { false }
      state { 'new' }
    end

    trait :no_email do
      email { nil }
    end

    trait :waiting do
      state { 'waiting' }

      after :build do |user|
        user.stub(:eligible_pull_requests_count) { 4 }
      end
    end

    trait :completed do
      state { 'completed' }

      after :build do |user|
        user.stub(:eligible_pull_requests_count) { 4 }
        user.stub(:mature_pull_requests_count) { 4 }
      end
    end
  end
end
