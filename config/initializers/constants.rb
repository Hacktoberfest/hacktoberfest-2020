# frozen_string_literal: true

module Hacktoberfest
  module_function

  def start_date
    @start_date ||= Time.parse(ENV.fetch('START_DATE')).utc
  end

  def end_date
    @end_date ||= Time.parse(ENV.fetch('END_DATE')).utc
  end

  def rules_date
    @rules_date ||= Time.parse(ENV.fetch('RULES_DATE')).utc
  end

  def pull_request_maturation_days
    @pull_request_maturation_days ||= ENV.fetch('MATURATION_DAYS', 7).to_i.days
  end

  def airtable_key_present?
    ENV.fetch('AIRTABLE_API_KEY', nil).present?
  end

  def sidekiq_enterprise_available?
    ENV.fetch('BUNDLE_ENTERPRISE__CONTRIBSYS__COM', nil).present?
  end

  def pre_launch?
    Time.zone.now < start_date
  end

  def ended?
    Time.zone.now > end_date
  end
end
