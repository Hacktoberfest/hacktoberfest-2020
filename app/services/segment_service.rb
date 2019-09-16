# frozen_string_literal: true

class SegmentService
  def initialize(user)
    @user = user
  end

  def identify(traits = {})
    Analytics.identify(
      user_id: @user.id,
      traits: traits
    )
  end

  def track(event_name)
    Analytics.track(
      user_id: @user.id,
      event: event_name
    )
  end
end
