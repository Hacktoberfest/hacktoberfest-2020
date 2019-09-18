# frozen_string_literal: true

class Project
  def initialize(issue)
    @issue = issue
  end

  def language
    @issue.repository.language.name
  end

  def number
    @issue.number
  end

  def repository_description
    @issue.repository.description
  end

  def repository_name
    @issue.repository.name
  end

  def title
    @issue.title
  end

  def url
    @issue.url
  end
end
