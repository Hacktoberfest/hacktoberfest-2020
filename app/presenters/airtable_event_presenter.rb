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
     @event["Event State"]
  end

  def city
    @event['Event City']
  end

  def country
    @event['Event Country']
  end

  def location
    location = ""

    unless city.blank?
      location += "#{city}, "
    end

    unless state.blank?
      location += "#{state}, "
    end

    location += country

    location
  end

  def url
    @event["Event URL"]
  end

  def organizer
    @event["Event Organizer"]
  end
  
  def published?
    @event['Published?']
  end
end
