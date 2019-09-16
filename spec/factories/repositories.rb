FactoryBot.define do
  factory :repository do
    banned { false }
    description { "A GitHub repository" }
    name { "repository-name" }
    full_name { "name-of-owner/repository-name" }
    sequence(:gh_database_id) { |n| n }
    sequence(:url) { |n| "https://example.com/#{n}" }

    after(:build) do |repo|
      repo.language = Language.first || build(:language)
    end
  end
end
