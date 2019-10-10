# frozen_string_literal: true

# Report model is used to create, validate, and send reports to airtable.
class Report
  include ActiveModel::Model

  GITHUB_REPO_URL_REGEX = %r{github.com\/([\w.-]+\/[\w.-]+)}.freeze
  INVALID_URL_MESSAGE = <<~INVALID_URL_MESSAGE.squish.freeze
    The GitHub repository url is invalid. Please include the full url of the
    repository including the name and owners.
    Example: "https://github.com/user/repository"
  INVALID_URL_MESSAGE

  attr_accessor :url

  validates :url, format: { with: GITHUB_REPO_URL_REGEX,
                            message: INVALID_URL_MESSAGE }
end
