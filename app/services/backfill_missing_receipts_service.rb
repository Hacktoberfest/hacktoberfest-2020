# frozen_string_literal: true

module BackfillMissingReceiptsService
  module_function

  def call
    User.where(state: 'completed', receipt: nil).select(:id).find_in_batches do |group|
      group.each { |user| BackfillReceiptJob.perform_async(user.id) }
    end
  end
end
