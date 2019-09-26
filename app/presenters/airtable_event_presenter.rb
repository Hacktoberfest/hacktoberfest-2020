# frozen_string_literal: true

class AirtableEventPresenter
  class ParseError < StandardError; end

  def initialize(event)
    if event
      @event = event
    else
      raise(ParseError, 'Event not provided.')
    end
    validate
  end

  def name
    @event['Event Name']
  end

  def date
    date_time_arr = @event['Event Start Date/Time (Real)'].split(' ')
    date = date_time_arr.first
    Date.strptime(date, '%m/%d/%Y')
  rescue StandardError
    nil
  end

  def state
    @event['Event State']
  end

  def city
    @event['Event City']
  end

  def country
    @event['Event Country']
  end

  def location
    location = ''

    location += "#{city}, " if city.present?

    location += "#{state}, " if state.present?

    location += country

    location
  end

  def url
    @event['Event URL']
  end

  def organizer
    @event['Event Organizer']
  end

  def published?
    @event['Published?']
  end

  def featured?
    @event['Featured?']
  end

  def current?
    date > Date.yesterday
  end

  protected

  def validate
    %i[name url country date].each do |method|
      raise(ParseError, 'Invalid event.') if send(method).nil?
    end
  end
end
