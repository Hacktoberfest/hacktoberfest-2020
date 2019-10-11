# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :require_user_logged_in!

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(params.require(:report).permit(:url))
    if @report.save
      render :create
    else
      render :new
    end
  end
end
