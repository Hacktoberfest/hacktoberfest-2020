# frozen_string_literal: true

class BanAllReposJob < ApplicationJob
  queue_as :ban_repos

  def perform
    BanAllReposService.call
  end
end
