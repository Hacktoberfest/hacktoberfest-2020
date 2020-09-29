# frozen_string_literal: true

class MlhEventPresenter
  class ParseError < StandardError; end

  def initialize(event)
    @event = event
    raise(ParseError, 'Event not provided.') unless @event

    validate
  end

  def name
    @event.dig('attributes', 'title')
  end

  def date
    Date.strptime(@event.dig('attributes', 'startDate'), '%Y-%m-%d')
  rescue StandardError
    nil
  end

  def time_zone
    @event.dig('attributes', 'timeZone').gsub(/_/, ' ')
  end

  def city
    @event.dig('attributes', 'location', 'city')
  end

  def country
    @event.dig('attributes', 'location', 'country')
  end

  def location
    location = ''

    location += "#{city}, " if city.present?

    location += country

    location
  end

  def url
    @event.dig('links', 'view')
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
