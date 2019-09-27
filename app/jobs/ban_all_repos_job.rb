
# frozen_string_literal: true

class BanAllReposJob
  include Sidekiq::Worker

  def perform
    BanAllReposService.call
  end
end
