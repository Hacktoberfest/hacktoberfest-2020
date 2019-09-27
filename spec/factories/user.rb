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
      waiting_since { Date.today }

      after :build do |user|
        allow(user).to receive(:eligible_pull_requests_count).and_return(4)
      end
    end

    trait :completed do
      state { 'completed' }

      after :build do |user|
        allow(user).to receive(:eligible_pull_requests_count).and_return(4)
        allow(user).to receive(:waiting_since).and_return(Date.today - 8)
      end
    end

    after :build do |user|
      allow(user).to receive(:github_emails).and_return([user.email])
    end
  end
end
