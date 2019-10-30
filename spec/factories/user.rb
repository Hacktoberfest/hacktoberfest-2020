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
      waiting_since { Time.zone.today }

      after :build do |user|
        allow(user).to receive(:eligible_pull_requests_count).and_return(4)
      end
    end

    trait :completed do
      state { 'completed' }

      # setting receipt data here for validations, else the create fails
      receipt { {'test': 'test' }.to_json }

      after :build do |user|
        allow(user).to receive(:eligible_pull_requests_count).and_return(4)
        allow(user).to receive(:waiting_since).and_return(Time.zone.today - 8)
      end
    end

    trait :incompleted do
      state { 'incompleted' }
      receipt { {'test': 'test' }.to_json }

      after :build do |user|
        allow(user).to receive(:eligible_pull_requests_count).and_return(3)
        allow(user).to receive(:waiting_since).and_return(Time.zone.today - 8)
      end
    end

    trait :won_shirt do
      state { 'won_shirt' }
      receipt { {'test': 'test' }.to_json }
      shirt_coupon
    end

    trait :won_sticker do
      state { 'won_sticker' }
      receipt { {'test': 'test' }.to_json }
      sticker_coupon
    end

    trait :winner_with_receipt do
      state { 'won_shirt' }
      receipt {
        [{'github_pull_request'=>
          {'graphql_hash'=>
             {'id'=>'MDExOlB1bGxSZXF1ZXN0MzI1NDc3OTA3',
              'url'=>'https://github.com/raise-dev/hacktoberfest-test/pull/18',
              'body'=>'',
              'title'=>'Peculiar branch',
              'labels'=>{'edges'=>[]},
              'createdAt'=>'2019-10-07T20:23:23Z',
              'repository'=>{'databaseId'=>211178535}}}},
          {'github_pull_request'=>
            {'graphql_hash'=>
              {'id'=>'MDExOlB1bGxSZXF1ZXN0MzI1NDc3OTY1',
              'url'=>'https://github.com/raise-dev/hacktoberfest-test/pull/19',
              'body'=>'',
              'title'=>'Fun branch',
              'labels'=>{'edges'=>[]},
              'createdAt'=>'2019-10-07T20:23:33Z',
              'repository'=>{'databaseId'=>211178535}}}},
          {'github_pull_request'=>
            {'graphql_hash'=>
              {'id'=>'MDExOlB1bGxSZXF1ZXN0MzI1NDc4MDIy',
              'url'=>'https://github.com/raise-dev/hacktoberfest-test/pull/20',
              'body'=>'',
              'title'=>'Super branch',
              'labels'=>{'edges'=>[]},
              'createdAt'=>'2019-10-07T20:23:42Z',
              'repository'=>{'databaseId'=>211178535}}}},
          {'github_pull_request'=>
            {'graphql_hash'=>
              {'id'=>'MDExOlB1bGxSZXF1ZXN0MzI1NDc4MDc2',
              'url'=>'https://github.com/raise-dev/hacktoberfest-test/pull/21',
              'body'=>'',
              'title'=>'readme addition',
              'labels'=>{'edges'=>[]},
              'createdAt'=>'2019-10-07T20:23:51Z',
              'repository'=>{'databaseId'=>211178535}}}},
          {'github_pull_request'=>
            {'graphql_hash'=>
              {'id'=>'MDExOlB1bGxSZXF1ZXN0MzI1NDgxMzA4',
              'url'=>'https://github.com/raise-dev/hacktoberfest-test/pull/22',
              'body'=>'',
              'title'=>'Fakerson',
              'labels'=>{'edges'=>[{'node'=>{'name'=>'invalid'}}]},
              'createdAt'=>'2019-10-07T20:32:11Z',
              'repository'=>{'databaseId'=>211178535}}}}]
          }
      shirt_coupon
    end

    after :build do |user|
      allow(user).to receive(:github_emails).and_return([user.email])
    end
  end
end
