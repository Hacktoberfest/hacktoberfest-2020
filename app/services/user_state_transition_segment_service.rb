# frozen_string_literal: true

# This class relays the appropiate data to Segment for specific
# user state transitions.
module UserStateTransitionSegmentService
  module_function

  def call(user, transition)
    case transition.event
    when :register then register(user)
    when :wait then wait(user)
    when :complete then complete(user)
    when :incomplete then incomplete(user)
    when :ineligible then ineligible(user)
    when :won then won(user, transition)
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

  def wait(user)
    segment(user).track('user_waiting')
    segment(user).identify(state: 'waiting')
  end

  def complete(user)
    segment(user).track('user_completed')
    segment(user).identify(state: 'completed')
  end

  def incomplete(user)
    segment(user).track('user_incompleted')
    segment(user).identify(state: 'incomplete')
  end

  def ineligible(user)
    segment(user).track('user_ineligible')
    segment(user).identify(state: 'ineligible')
  end

  def won(user, transition)
    if transition.to == 'won_shirt'
      segment(user).track('user_won_shirt')
      segment(user).identify(
        state: 'won_shirt'
      )
    elsif transition.to == 'won_sticker'
      segment(user).track('user_won_sticker')
      segment(user).identify(
        state: 'won_sticker'
      )
    end
  end

  def segment(user)
    SegmentService.new(user)
  end
end
