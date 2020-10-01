# frozen_string_literal: true

module PagesHelper
  def all_events
    MlhTable.new.records['data'].map do |e|
      MlhEventPresenter.new(e)
    rescue MlhEventPresenter::ParseError
      # Ignore invalid events
    end.compact
  rescue JSON::ParserError
    AirtablePlaceholderService.call('Meetups').map do |e|
      MlhEventPresenter.new(e)
    end.compact
  end

  def front_page_events
    present_featured_events(AirrecordTable.new.all_records('Event List'))
  rescue StandardError
    present_featured_events(AirtablePlaceholderService.call('Event List'))
  end

  def present_featured_events(events)
    events.map do |e|
      FeaturedEventPresenter.new(e)
    rescue FeaturedEventPresenter::ParseError
      # Ignore invalid events
    end.compact.select(&:current?).sort_by(&:date)
  end

  def front_page_projects
    present_featured_projects(AirrecordTable.new.all_records('Themed Repos'))
  rescue StandardError
    present_featured_projects(AirtablePlaceholderService.call('Themed Repos'))
  end

  def present_featured_projects(projects)
    projects.compact.sample(3)
  end

  def global_stats
    stats_arr = [
      { amount: '61,956', title: 'CHALLENGE COMPLETIONS' },
      { amount: '482,182', title: 'PULL REQUESTS OPENED' },
      { amount: '154,466', title: 'PARTICIPATING REPOSITORIES' }
    ]
    stats_arr.map { |s| Hashie::Mash.new(s) }
  end

  def all_faqs
    AirrecordTable.new.all_records('FAQs')
  rescue StandardError
    AirtablePlaceholderService.call('FAQs')
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

  def faq_item(faq)
    [faq['Category'].strip, faq['Question'].strip]
  end

  def present_faqs(faqs, category)
    faqs.select { |q| q['Category'].strip == category }
  end
end
