# frozen_string_literal: true

class EventsPresenter
  def display_create_an_event?
    !Hacktoberfest.ended?
  end

  def display_look_at_events?
    Hacktoberfest.ended?
  end

  def display_rsvp_link?
    !Hacktoberfest.ended?
  end
end
