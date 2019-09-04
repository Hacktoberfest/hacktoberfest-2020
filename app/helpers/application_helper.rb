# frozen_string_literal: true

module ApplicationHelper
  def markdown(source)
    Kramdown::Document.new(source.to_s).to_html
  end
end
