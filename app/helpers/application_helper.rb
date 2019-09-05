# frozen_string_literal: true

# rubocop:disable Rails/OutputSafety
module ApplicationHelper
  def markdown(source)
    Kramdown::Document.new(source.to_s).to_html.html_safe
  end
end
# rubocop:enable Rails/OutputSafety
