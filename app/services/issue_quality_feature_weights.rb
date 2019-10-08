# frozen_string_literal: true

class IssueQualityFeatureWeights
  CODE_OF_CONDUCT = 1000
  ISSUE_PARTICIPANTS = 2
  ISSUE_TIMELINE_EVENTS = 1
  REPOSITORY_FORKS = 10
  REPOSITORY_STARS = 3
  REPOSITORY_WATCHERS = 100

  attr_accessor(
    :code_of_conduct,
    :issue_participants,
    :issue_timeline_events,
    :repository_forks,
    :repository_stars,
    :repository_watchers
  )

  def self.default_weights
    default_weights = IssueQualityFeatureWeights.new
    default_weights.code_of_conduct = CODE_OF_CONDUCT
    default_weights.issue_participants = ISSUE_PARTICIPANTS
    default_weights.issue_timeline_events = ISSUE_TIMELINE_EVENTS
    default_weights.repository_forks = REPOSITORY_FORKS
    default_weights.repository_stars = REPOSITORY_STARS
    default_weights.repository_watchers = REPOSITORY_WATCHERS
    default_weights
  end
end
