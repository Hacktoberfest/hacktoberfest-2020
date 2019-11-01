# frozen_string_literal: true

module ImportPrMetadataService
  module_function

  def call(user)
    pr_service = PullRequestService.new(user, randomize_token: true)
    pr_data = pr_service.all

    pr_data.map do |pr|
      ImportOnePrMetadataJob.perform_async(pr.url)
    end
  end
end
