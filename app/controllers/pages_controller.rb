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
    @events = all_events.select(&:published?) if all_events.present?
  end

  def event_kit; end

  def start; end

  def report; end

  def api_error; end

  private

  def all_events
    return if AirrecordTable.new.table('Meetups').all.blank?

    AirrecordTable.new.table('Meetups').all.map do |e|
      AirtableEventPresenter.new(e)
    # rubocop:disable Lint/HandleExceptions
    rescue AirtableEventPresenter::ParseError
      # Ignore invalid events
      # rubocop:enable Lint/HandleExceptions
    end.compact
  end

  def front_page_events
    all_events
      .select(&:current?)
      .sample(4)
      .sort_by(&:date)
  end
end
