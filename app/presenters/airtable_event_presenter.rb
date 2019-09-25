# frozen_string_literal: true

class AirtableEventPresenter
  def initialize(event)
    @event = event
  end

  def name
    @event['Event Name']
  end

  def date
    DateTime.parse(@event['Event Start Date/Time'])
  end

  def state
    unless @event["Event State"].blank? 
      @event["Event State"] + ', '
    else
      ' '
    end
  end

  def city
    @event['Event City']
  end

  def country
    @event['Event Country']
  end

  def location
    city + state + country
  end

  def url
    @event["Event URL"]
  end

  def organizer
    @event["Event Organizer"]
  end
end
