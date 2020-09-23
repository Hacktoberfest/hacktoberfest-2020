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
    present_faqs(filter_faqs(faqs))
  end

  def events
    @events = all_events
  end

  def event_kit; end

  def api_error; end

  def github_unauthorized_error; end

  def github_suspended_error; end

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

  def filter_faqs(faqs)
    # Get all the main FAQs
    main = faqs.select do |faq|
      faq['Site Stage'].map(&:strip).include?('Main')
    end

    # Get the category & question for each item in main
    main_qs = main.map { |faq| faq_item(faq) }

    # Get pre launch FAQs that aren't in main
    pre_launch = faqs.select do |faq|
      faq['Site Stage'].map(&:strip).include?('Pre Launch') &&
        !main_qs.include?(faq_item(faq))
    end

    # Combine main + extras from pre launch
    main + pre_launch
  end

  def present_faqs(faqs)
    @faqs_rules = faqs.select { |q| q['Category'] == 'Rules' }
    @faqs_general = faqs.select { |q| q['Category'] == 'General' }
    @faqs_events = faqs.select { |q| q['Category'] == 'Events' }
    @faqs_shipping = faqs.select { |q| q['Category'] == 'Shipping' }
  end


  def faq_item(faq)
    [faq['Category'].strip, faq['Question'].strip]
  end
end
