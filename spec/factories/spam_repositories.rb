FactoryBot.define do
  factory :spam_repository do
    sequence(:github_id) { |n| n }
  end
end
