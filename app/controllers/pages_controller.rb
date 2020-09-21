# frozen_string_literal: true

class PagesController < ApplicationController
  include PagesHelper

  def index
    @events = front_page_events
    @projects = ProjectService.sample(9)
    @climate_repositories = ClimateProjectService.sample(3)
    @global_stats = global_stats
    if Hacktoberfest.ended?
      render 'pages/homepage/closing_homepage'
    else
      render 'pages/homepage/active_homepage'
    end
  end

  def faqs
    begin
      faqs = AirrecordTable.new.all_records('FAQs')
    rescue StandardError
      faqs = AirtablePlaceholderService.call('FAQs')
    end
    present_faqs(faqs)
  end

  def events
    @events = all_events
  end

  def event_kit; end

  def api_error; end

  private

  def all_events
    MlhTable.new.records['data'].map do |e|
      MlhEventPresenter.new(e)
    rescue MlhEventPresenter::ParseError
      # Ignore invalid events
    end.compact
  end

  def front_page_events
    present_featured_events(AirrecordTable.new.all_records('Event List'))
  rescue StandardError
    present_featured_events(AirtablePlaceholderService.call('Event List'))
  end

  def global_stats
    stats_arr = [
      { amount: '61,956', title: 'CHALLENGE COMPLETIONS' },
      { amount: '482,182', title: 'PULL REQUESTS OPENED' },
      { amount: '154,466', title: 'PARTICIPATING REPOSITORIES' }
    ]
    stats_arr.map { |s| Hashie::Mash.new(s) }
  end

  def present_faqs(faqs)
    @faqs_rules = faqs.select { |q| q['Category'] == 'Rules' }
    @faqs_general = faqs.select { |q| q['Category'] == 'General' }
    @faqs_events = faqs.select { |q| q['Category'] == 'Events' }
    @faqs_shipping = faqs.select { |q| q['Category'] == 'Shipping' }
  end
end
