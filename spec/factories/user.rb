# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { "Testerson McTest " }
    email { "test@mail.com" }
    uid { 40510669 }
    provider_token { ENV['GITHUB_ACCESS_TOKEN'] }
  end
end
