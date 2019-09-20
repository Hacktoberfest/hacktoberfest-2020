# frozen_string_literal: true

class PagesController < ApplicationController
  def index
    @meetups = meetups.select do |m|
      m.fields.key?('Featured?')
    end.first
    @issues = ProjectService.sample
  end

  def faqs
    faq = AirrecordTable.new.table('FAQ').all
    @faqs_rules = faq.select { |q| q.fields['Category'] == 'Rules' }
    @faqs_general = faq.select { |q| q.fields['Category'] == 'General' }
    @faqs_events = faq.select { |q| q.fields['Category'] == 'Events' }
    @faqs_shipping = faq.select { |q| q.fields['Category'] == 'Shipping' }
  end

  def meetups
    meetups = AirrecordTable.new.table('Meetups').all
    @meetups = meetups.sort_by { |e| e['Event Start Date/Time'] }
  end

  def webinars
    webinars = AirrecordTable.new.table('Webinar Listings').all
    @webinars = webinars.sort_by { |w| w['Event Start Date/Time'] }
  end

  private

  def start
  end
end
