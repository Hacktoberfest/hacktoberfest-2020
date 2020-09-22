# frozen_string_literal: true

# This class relays the appropiate data to Segment for specific
# user state transitions.
# rubocop:disable Metrics/CyclomaticComplexity
module UserStateTransitionSegmentService
  module_function

  def call(user, transition)
    case transition.event
    when :register then register(user)
    when :wait then wait(user)
    when :complete then complete(user)
    when :retry_complete then complete(user)
    when :incomplete then incomplete(user)
    when :insufficient then insufficient(user)
    when :won then won(user, transition)
    when :gifted then gifted(user)
    end
  end

  def register(user)
    segment(user).identify(
      email: user.email,
      digitalocean_marketing_emails: user.digitalocean_marketing_emails,
      intel_marketing_emails: user.intel_marketing_emails,
      dev_marketing_emails: user.dev_marketing_emails,
      category: user.category,
      country: user.country,
      pull_requests_count: user.score,
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

  def insufficient(user)
    segment(user).track('user_insufficient')
    segment(user).identify(state: 'insufficient')
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

  # TODO: change this to gifted(user, transition) and check transition.to to
  # add case for 'gifted_shirt'
  def gifted(user)
    segment(user).identify(state: 'gifted_sticker')
    segment(user).track('user_gifted_sticker')
  end

  def segment(user)
    SegmentService.new(user)
  end
end
# rubocop:enable Metrics/CyclomaticComplexity
