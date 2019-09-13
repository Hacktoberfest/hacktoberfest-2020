# frozen_string_literal: true

require 'segment/analytics'

# stub_value = if Rails.env.test?; stub: true; end
Analytics = Segment::Analytics.new(
  stub: true,
  write_key: ENV['SEGMENT_WRITE_KEY'],
  on_error: proc { |_status, msg| msg }
)
