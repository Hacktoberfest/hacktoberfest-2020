# frozen_string_literal: true

module BackfillMissingReceiptsService
  module_function

  def call
    users = User.
      where(state: 'completed').
      or(User.where(state:'won_shirt')).
      or(User.where(state:'won_sticker'))

    users.where(receipt: nil).select(:id).find_in_batches do |group|
      group.each { |user| BackfillReceiptJob.perform_async(user.id) }
    end
  end
end
