# frozen_string_literal: true

module Hacktoberfest
  module_function

  def start_date
    @start_date ||= Date.parse(ENV.fetch('START_DATE'))
  end

  def end_date
    @end_date ||= Date.parse(ENV.fetch('END_DATE'))
  end

  def pull_request_maturation_days
    @pull_request_maturation_days ||= ENV.fetch('MATURATION_DAYS', 7).to_i.days
  end

  def pre_launch?
    Time.zone.today < start_date
  end

  def ended?
    Time.zone.today > end_date
  end

  def active?
    Time.zone.today > start_date && Time.zone.today < end_date
  end
end
