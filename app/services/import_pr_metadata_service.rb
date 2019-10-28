# frozen_string_literal: true

module ImportPRMetadataService
  module_function

  def call(user)
    pr_data = user.pull_requests

    pr_data.map do |pr|
      PRStat.where(pr_id: pr.id).first_or_create(data: pr)
    end
  end
end