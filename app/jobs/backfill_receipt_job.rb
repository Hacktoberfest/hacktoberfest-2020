# frozen_string_literal: true

class BackfillReceiptJob
  include Sidekiq::Worker
  sidekiq_options queue: :default, retry: 4

  def perform(user_id)
    user = User.find(user_id)

    BackfillReceiptService.call(user)
  end
end
