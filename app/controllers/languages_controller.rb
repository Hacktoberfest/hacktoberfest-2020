# frozen_string_literal: true

class LanguagesController < ApplicationController
  def projects
    if params[:language_id].present? &&
       (language = Language.find_by_id(params[:language_id]))
      @projects = ProjectService.language_sample(language, 9)
    else
      @projects = ProjectService.sample(9)
    end
    render partial: 'languages/all_projects', locals: { projects: @projects }
  end
end
