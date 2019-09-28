# frozen_string_literal: true

class LanguagesController < ApplicationController
  def projects
    binding.pry
    ProjectService.language_sample(params["language_id"], 9)
  end
end
