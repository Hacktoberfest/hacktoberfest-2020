# frozen_string_literal: true

module UserPullRequestSegmentUpdaterService
  def call(user)
    segment(user).identify(pull_requests_count: user.score)
  end
end