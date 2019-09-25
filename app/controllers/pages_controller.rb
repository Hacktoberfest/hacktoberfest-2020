# frozen_string_literal: true

class PagesController < ApplicationController
  def index
    @events = featured_meetups.first(4)
    @projects = ProjectService.sample(9)
    @climate_repository = ClimateProjectService.sample(3)
  end

  def faqs
    faq = AirrecordTable.new.table('FAQ').all
    @faqs_rules = faq.select { |q| q.fields['Category'] == 'Rules' }
    @faqs_general = faq.select { |q| q.fields['Category'] == 'General' }
    @faqs_events = faq.select { |q| q.fields['Category'] == 'Events' }
    @faqs_shipping = faq.select { |q| q.fields['Category'] == 'Shipping' }
  end

  def meetups
     unless all_events.blank?
      published_events = all_events.select do |e|
        e['Published?'] == true
      end

      @events = published_events.map { |e| ::AirtableEventPresenter.new(e) }
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
    AirrecordTable.new.table('Meetups').all
  end

  def featured_events
    all_events.select{ |m| m.fields.key?('Featured?') }
  end
end
