# frozen_string_literal: true

# This class relays the appropiate data to Segment for specific
# user state transitions.
module UserStateTransitionSegmentService
  module_function

  def call(user, transition)
    if transition.event == :register
      register(user)
    elsif transition.event == :ineligible
      ineligible(user)
    end
  end

  def register(user)
    segment = SegmentService.new(user)
    segment.identify(
      email: user.email,
      marketing_emails: user.marketing_emails
    )
  end

  def ineligible(user)
    segment = SegmentService.new(user)
    properties = { pull_requests_count: user.score }
    segment.track('user_ineligible', properties)
    segment.identify(state: 'ineligible')
  end
end
