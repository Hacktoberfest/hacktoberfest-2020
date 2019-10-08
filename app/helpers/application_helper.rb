# frozen_string_literal: true

# rubocop:disable Rails/OutputSafety
module ApplicationHelper
  def markdown(source)
    Kramdown::Document.new(source.to_s).to_html.html_safe
  end

  def active_path_class?(test_path, test_path_2)
    return 'active' if request.path == test_path || request.path == test_path_2

    ''
  end

  def show_svg(path)
    File.open("app/assets/images/#{path}", 'rb') do |file|
      raw file.read
    end
  end
end
# rubocop:enable Rails/OutputSafety
