class PullRequestFilterService
  def initialize(array)
    @array = array
  end

  def filter
    filter = @array.select do |e|
      !e.label_names.include?('invalid') && e.created_at >= ENV["START_DATE"] && e.created_at >= ENV["END_DATE"]
    end
  end
end
