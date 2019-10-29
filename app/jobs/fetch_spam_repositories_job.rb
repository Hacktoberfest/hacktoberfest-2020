# frozen_string_literal: true

class FetchSpamRepositoriesJob
  include Sidekiq::Worker
  sidekiq_options queue: :default, retry: 3

  def perform
    FetchSpamRepositoriesService.call
  end
end
