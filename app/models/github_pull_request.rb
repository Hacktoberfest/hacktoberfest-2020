# frozen_string_literal: true

class GithubPullRequest
  attr_accessor :graphql_hash

  def initialize(hash)
    @graphql_hash = hash
  end

  def id
    @graphql_hash.id
  end

  def repo_id
    @graphql_hash.repository.databaseId
  end

  def title
    @graphql_hash.title
  end

  def body
    @graphql_hash.body
  end

  def url
    @graphql_hash.url
  end

  def created_at
    @graphql_hash.createdAt
  end

  def merged?
    @graphql_hash.merged
  end

  def label_names
    @graphql_hash.labels.edges.map do |e|
      e.node.name.downcase
    end
  end

  def name
    url.split('/')[4]
  end

  def owner
    url.split('/')[3]
  end

  def name_with_owner
    owner + '/' + name
  end
end
