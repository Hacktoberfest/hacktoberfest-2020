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
    present_faqs(filter_faqs(all_faqs))
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
