class ReportsController < ApplicationController
  def new; end

  def create
    ReportSpamService.new(params['repository']['url']).report
    render 'pages/report_thanks'
  end
end
