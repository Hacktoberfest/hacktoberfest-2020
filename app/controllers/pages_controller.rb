# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :disallow_registered_user!, only: :start
  before_action :require_user_logged_in!, only: :report

  def index
    @events = front_page_events
    @projects = ProjectService.sample(9)
    @climate_repository = ClimateProjectService.sample(3)
  end

  def faqs
    faq = AirrecordTable.new.table('FAQ').all(view: 'Grid view')
    @faqs_rules = faq.select { |q| q.fields['Category'] == 'Rules' }
    @faqs_general = faq.select { |q| q.fields['Category'] == 'General' }
    @faqs_events = faq.select { |q| q.fields['Category'] == 'Events' }
    @faqs_shipping = faq.select { |q| q.fields['Category'] == 'Shipping' }
  end

  def events
    @events = all_events.select(&:published?)
  end

  def event_kit; end

  def start; end

  def api_error; end

  private

  def all_events
    all_meetups = AirrecordTable.new.table('Meetups').all
    return [] if all_meetups.blank?

    all_meetups.map do |e|
      AirtableEventPresenter.new(e)
    rescue AirtableEventPresenter::ParseError
      # Ignore invalid events
    end.compact
  end

  def front_page_events
    all_events
      .select(&:current?)
      .sample(4)
      .sort_by(&:date)
  end
end
