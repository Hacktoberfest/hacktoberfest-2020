# frozen_string_literal: true

User.create!
User.create!
User.create!

10.times do
  FactoryBot.create(:issue)
end

Language.create(name: "javascript")

Language.create(name: "ruby")

Language.create(name: "python")

Language.create(name: "go")

Repository.all.each do |r|
  r.language_id = Language.first.id
  r.save
end
