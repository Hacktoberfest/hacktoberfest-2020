# frozen_string_literal: true

class LanguagesController < ApplicationController
  def projects
    @projects = ProjectService.language_sample(params["language_id"].to_i, 9)
  end
end
