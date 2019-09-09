# frozen_string_literal: true

# This class relays the appropiate data to Segment for specific
# user state transitions.
module UserStateTransitionSegmentService
  def call(user, transition)
    case transition.event_name
    register(user) when :register
    when ...
    end
  end

  private

  def register(user)
    segment = SegmentService.new(user)
    segment.identify({
      email: user.email,
      marketing_emails: user.marketing_emails
    })
  end

  def ineligible(user)
    segment = SegmentService.new(user)
    segment.track('user_ineligible')
    segment.identify(state: 'ineligible')
  end
end
