# frozen_string_literal: true

# This class relays the appropiate data to Segment for specific
# user state transitions.
module UserStateTransitionSegmentService
  def self.call(user, transition)
    if transition == :register
      register(user)
    elsif transition == :ineligible
      ineligible(user)
    end
  end

  def self.register(user)
    segment = SegmentService.new(user)
    segment.identify(
      email: user.email,
      marketing_emails: user.marketing_emails
    )
  end

  def self.ineligible(user)
    segment = SegmentService.new(user)
    segment.track('user_ineligible')
    segment.identify(state: 'ineligible')
  end
end
