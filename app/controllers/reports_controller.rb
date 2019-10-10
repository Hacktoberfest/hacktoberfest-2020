class ReportsController < ApplicationController
  def new; end

  def create
    ReportSpamService.new(params['repository']['url']).report
  end
end
