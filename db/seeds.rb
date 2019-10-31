# frozen_string_literal: true

User.create!
User.create!
User.create!

10.times do
  FactoryBot.create(:issue)
end
Language.create(name: "Brainfuck")

Language.create(name: "C")

Language.create(name: "C#")

Language.create(name: "C++")

Language.create(name: "CSS")

Language.create(name: "Clojure")

Language.create(name: "CoffeeScript")

Language.create(name: "ColdFusion")

Language.create(name: "Coq")

Language.create(name: "Coq")

Language.create(name: "Dart")

Language.create(name: "Dockerfile")

Language.create(name: "F#")

Language.create(name: "Go")

Language.create(name: "HTML")

Language.create(name: "Haskell")

Language.create(name: "Java")

Language.create(name: "JavaScript")

Language.create(name: "Julia")

Language.create(name: "Jupyter Notebook")

Language.create(name: "Kotlin")

Language.create(name: "Lua")

Language.create(name: "MATLAB")

Language.create(name: "Objective-C")

Language.create(name: "PHP")

Language.create(name: "PLSQL")

Language.create(name: "Pascal")

Language.create(name: "Perl")

Language.create(name: "PowerShell")

Language.create(name: "Processing")

Language.create(name: "Python")

Language.create(name: "QML")

Language.create(name: "R")

Language.create(name: "Rich Text Format")

Language.create(name: "Ruby")

Language.create(name: "Rust")

Language.create(name: "Scala")

Language.create(name: "Shell")

Language.create(name: "Swift")

Language.create(name: "TSQL")

Language.create(name: "TeX")

Language.create(name: "TypeScript")

Language.create(name: "Vim script")

Language.create(name: "Vue")

Repository.all.each do |r|
  r.language_id = Language.second.id
  r.save
end
