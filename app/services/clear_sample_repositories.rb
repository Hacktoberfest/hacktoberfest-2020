# frozen_string_literal: true

class ClearSampleRepositories
  def self.clear_all
    Repository.destroy_all
  end
end
