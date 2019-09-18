# frozen_string_literal: true

require 'rails_helper'

describe Project do
  context 'Given an issue with a repository and language' do
    it 'exposes the expected properties' do
      language = create(:language, name: 'Python')
      repository = create(
        :repository,
        language: language,
        name: 'HelloWorld',
        description: "An app to display 'Hello World'"
      )
      issue = create(
        :issue,
        repository: repository,
        number: 123,
        title: "App does not display 'Hello World'",
        url: 'https://github.com/example/helloworld/issues/1'
      )

      project = Project.new(issue)

      expect(project.language).to eq language.name
      expect(project.number).to eq issue.number
      expect(project.repository_name).to eq repository.name
      expect(project.repository_description).to eq repository.description
      expect(project.title).to eq issue.title
      expect(project.url).to eq issue.url
    end
  end
end
