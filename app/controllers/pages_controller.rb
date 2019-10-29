# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :disallow_registered_user!, only: :start

  def index
    @events = front_page_events
    @projects = ProjectService.sample(9)
    @climate_repository = ClimateProjectService.sample(3)
  end

  def faqs
    faq = AirrecordTable.new.all_records('FAQ')
    @faqs_rules = faq.select { |q| q['Category'] == 'Rules' }
    @faqs_general = faq.select { |q| q['Category'] == 'General' }
    @faqs_events = faq.select { |q| q['Category'] == 'Events' }
    @faqs_shipping = faq.select { |q| q['Category'] == 'Shipping' }
  end

  def events
    return @events = [] if all_events.blank?

    @events = all_events.select(&:published?)
  end

  def event_kit; end

  def start; end

  def api_error; end

  private

  def all_events
    AirrecordTable.new.all_records('Meetups').map do |e|
      AirtableEventPresenter.new(e)
    rescue AirtableEventPresenter::ParseError
      # Ignore invalid events
    end.compact
  end

  def front_page_events
    all_events
      .select(&:current?)
      .select(&:published?)
      .select(&:featured?)
      .sample(4)
      .sort_by(&:date)
  end
end
