# frozen_string_literal: true

# rubocop:disable Rails/OutputSafety
module ApplicationHelper
  def markdown(source)
    Kramdown::Document.new(source.to_s).to_html.html_safe
  end
  
  def active_path_class?(test_path)
    return 'active' if request.path == test_path
    ''
  end
end
# rubocop:enable Rails/OutputSafety
