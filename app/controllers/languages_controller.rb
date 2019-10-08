# frozen_string_literal: true

class LanguagesController < ApplicationController
  def projects
    @projects = if params[:language_id].present? &&
                   (language = Language.find_by(id: params[:language_id]))
                  ProjectService.language_sample(language, 9)
                else
                  ProjectService.sample(9)
                end
    render partial: 'languages/all_projects', locals: { projects: @projects }
  end
end
