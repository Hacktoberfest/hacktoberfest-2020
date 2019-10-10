# frozen_string_literal: true

# Report model is used to create, validate, and send reports to airtable.
class Report
  include ActiveModel::Model

  GITHUB_REPO_URL_REGEX = %r{github.com\/([\w.-]+\/[\w.-]+)}.freeze

  attr_accessor :url

  validates :url, format: { with: GITHUB_REPO_URL_REGEX }

  def save
    return false unless valid?

    true
  end
end
