# frozen_string_literal: true

module PagesHelper
  def present_featured_events(events)
    events.map do |e|
      FeaturedEventPresenter.new(e)
    rescue FeaturedEventPresenter::ParseError
      # Ignore invalid events
    end.compact.sample(4).sort_by(&:date)
  end
end
