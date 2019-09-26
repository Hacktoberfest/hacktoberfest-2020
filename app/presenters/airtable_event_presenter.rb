# frozen_string_literal: true

class AirtableEventPresenter
  class ParseError < StandardError; end

  def initialize(event)
    if event
      @event = event
    else
      raise(ParseError, "Event not provided.")
    end
    validate
  end

  def name
    @event['Event Name']
  end

  def date
    date_time_arr = @event['Event Start Date/Time (Real)'].split(' ')
    date = date_time_arr.first
    Date.strptime(date, "%m/%d/%Y")
  rescue
    nil
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

  def featured?
    @event['Featured?']
  end

  def after_yesterday?
    date > Date.yesterday
  end

  protected

  def validate
    [:name, :url, :country, :date].each do |method|
      if send(method).nil?
        raise(ParseError, "Invalid event.")
      end
    end
  end
end
