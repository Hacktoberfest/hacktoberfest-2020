# frozen_string_literal: true

class LanguagesController < ApplicationController

  def projects(language_id)
    ProjectService.language_sample(language_id, 9)
  end

end
