# frozen_string_literal: true

module BackfillReceiptService
  module_function

  def call(user)
    user.update(receipt: user.scoring_pull_requests.map { |pr| pr.github_pull_request.graphql_hash })
  end
end
