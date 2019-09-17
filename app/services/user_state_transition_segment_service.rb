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
    segment(user).identify(
      email: user.email,
      marketing_emails: user.marketing_emails,
      state: 'register'
    )
    segment(user).track('register')
  end

  def ineligible(user)
    segment(user).track('user_ineligible')
    segment(user).identify(state: 'ineligible')
  end

  def segment(user)
    SegmentService.new(user)
  end
end
