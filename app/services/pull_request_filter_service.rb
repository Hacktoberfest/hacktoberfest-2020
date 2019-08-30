# frozen_string_literal: true

class PullRequestFilterService
  def initialize(array)
    @array = array
  end

  def filter
    @array.select do |e|
        e.created_at >= ENV['START_DATE'] && e.created_at <= ENV['END_DATE']
    end
  end
end
