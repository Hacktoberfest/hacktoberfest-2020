# frozen_string_literal: true

class BanAllReposJob
  include Sidekiq::Worker
  sidekiq_options queue: :default, retry: 3

  def perform
    BanAllReposService.call
  end
end
