# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name              { 'Testerson McTest' }
    email             { 'test@mail.com' }
    uid               { rand(1..1_000_000) }
    provider_token    { user_github_token }
    terms_acceptance  { true }
    state             { 'registered' }
    country           { 'US' }

    trait :new do
      terms_acceptance { false }
      state { 'new' }

      after :build do |user|
        PullRequestFilterHelper.pr_stub_helper(user, [])
      end
    end

    trait :no_email do
      email { nil }
    end

    trait :waiting do
      state { 'waiting' }

      after :build do |user|
        PullRequestFilterHelper.pr_stub_helper(user, PR_DATA[:immature_array])
      end
    end

    trait :completed do
      state { 'completed' }

      # setting receipt data here for validations, else the create fails
      receipt { { "test": 'test' }.to_json }

      after :build do |user|
        PullRequestFilterHelper.pr_stub_helper(user, PR_DATA[:mature_array])
      end
    end

    trait :incompleted do
      state { 'incompleted' }
      receipt { { "test": 'test' }.to_json }

      after :build do |user|
        PullRequestFilterHelper.pr_stub_helper(
          user,
          PR_DATA[:mature_array][0...3]
        )
      end
    end

    trait :won_shirt do
      state { 'won_shirt' }
      receipt { { "test": 'test' }.to_json }
      shirt_coupon
    end

    trait :won_sticker do
      state { 'won_sticker' }
      receipt { { "test": 'test' }.to_json }
      sticker_coupon
    end

    after :build do |user|
      allow(user).to receive(:github_emails).and_return([user.email])
    end
  end
end
