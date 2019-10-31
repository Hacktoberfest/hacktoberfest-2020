# frozen_string_literal: true

module UserPullRequestSegmentUpdaterService
  module_function

  def call(user)
    # disable sending score events to segment temporarily
    # segment(user).identify(pull_requests_count: user.score)
  end

  def segment(user)
    SegmentService.new(user)
  end
end
