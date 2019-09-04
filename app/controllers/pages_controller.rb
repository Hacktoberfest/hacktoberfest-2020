# frozen_string_literal: true

class PagesController < ApplicationController
  def index
    @meetups = meetups.select do |m|
      m.fields.key?('Featured?')
    end
  end

  # rubocop:disable Metrics/AbcSize
  def faqs
    faq = AirrecordTable.new.table('FAQ').all
    @faqs_rules = faq.select { |q| q.fields['Category'] == 'Rules' }
    @faqs_general = faq.select { |q| q.fields['Category'] == 'General' }
    @faqs_events = faq.select { |q| q.fields['Category'] == 'Events' }
    @faqs_shipping = faq.select { |q| q.fields['Category'] == 'Shipping' }
  end
  # rubocop:enable Metrics/AbcSize

  def meetups
    meetups = AirrecordTable.new.table('Meetups').all
    @resources = AirrecordTable.new.table('Resource Links').all
    @meetups = meetups.sort_by { |e| e['Event Start Date/Time'] }
  end
end
