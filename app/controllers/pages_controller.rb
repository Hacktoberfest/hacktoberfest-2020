# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :disallow_registered_user!, only: :start

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
    unless all_events.blank?
      @events = all_events.select(&:published?)
    end
  end

  def webinars
    webinars = AirrecordTable.new.table('Webinar Listings').all
    @webinars = webinars.sort_by { |w| w['Event Start Date/Time'] }
  end

  def event_kit
  end

  private

  def all_events
    unless AirrecordTable.new.table('Meetups').all.blank?
      AirrecordTable.new.table('Meetups').all.map do |e|
        AirtableEventPresenter.new(e)
      rescue AirtableEventPresenter::ParseError
        #Ignore invalid events
      end.compact
    end
  end

  def front_page_events
    all_events
      .select(&:current?)
      .shuffle
      .first(4)
      .sort_by { |e| e.date }
  end
end
