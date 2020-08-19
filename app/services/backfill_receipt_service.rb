# frozen_string_literal: true

module BackfillReceiptService
  module_function

  def call(user)
    user.update(receipt: user.scoring_pull_requests_receipt)
  end
end
