# frozen_string_literal: true

class IdentifyJob
  include Sidekiq::Worker
  sidekiq_options queue: :default, retry: 4

  def perform(user_id)
    user = User.find(user_id)
    segment = SegmentService.new(user)
    segment.identify(state: user.state)
  end
end
