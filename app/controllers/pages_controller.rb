# frozen_string_literal: true

class PagesController < ApplicationController
  include PagesHelper

  def index
    @events = front_page_events
    @projects = ProjectService.sample(9)
    @featured_projects = front_page_projects
    @global_stats = global_stats
    if Hacktoberfest.ended?
      render 'pages/homepage/closing_homepage'
    else
      render 'pages/homepage/active_homepage'
    end
  end

  def faqs
    clean_faqs = filter_faqs(all_faqs)
    @faqs_rules = present_faqs(clean_faqs, 'Rules')
    @faqs_general = present_faqs(clean_faqs, 'General')
    @faqs_events = present_faqs(clean_faqs, 'Events')
    @faqs_shipping = present_faqs(clean_faqs, 'Shipping')
  end

  def events
    @events = all_events
  end

  def event_kit; end

  def api_error; end

  def github_unauthorized_error; end

  def github_suspended_error; end

  def tshirt; end

  def tree; end
end
