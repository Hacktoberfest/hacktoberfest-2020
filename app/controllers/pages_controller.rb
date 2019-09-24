# frozen_string_literal: true

class PagesController < ApplicationController
  def index
    @meetups = featured_meetups.first(4)
    @projects = ProjectService.sample(9)
  end

  def faqs
    faq = AirrecordTable.new.table('FAQ').all
    @faqs_rules = faq.select { |q| q.fields['Category'] == 'Rules' }
    @faqs_general = faq.select { |q| q.fields['Category'] == 'General' }
    @faqs_events = faq.select { |q| q.fields['Category'] == 'Events' }
    @faqs_shipping = faq.select { |q| q.fields['Category'] == 'Shipping' }
  end

  def meetups
    unless all_meetups.blank?
      current_meetups = all_meetups.select do |e|
          e['Published?'] == true
      end

      @meetups = current_meetups.sort_by { |e| e['Event Start Date/Time'] }
    end
  end

  def webinars
    webinars = AirrecordTable.new.table('Webinar Listings').all
    @webinars = webinars.sort_by { |w| w['Event Start Date/Time'] }
  end

  def event_kit
  end

  private

  def all_meetups
    AirrecordTable.new.table('Meetups').all
  end

  def featured_meetups
    all_meetups.select{ |m| m.fields.key?('Featured?') }
  end
end
