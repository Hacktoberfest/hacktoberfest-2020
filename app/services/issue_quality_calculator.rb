# frozen_string_literal: true

require 'matrix'

class IssueQualityCalculator
  def initialize(feature_weights = IssueQualityFeatureWeights.default_weights)
    @feature_weights = feature_weights
  end

  # rubocop:disable Metrics/ParameterLists
  def set_features(
    is_repository_code_of_conduct_present:,
    issue_participants:,
    issue_timeline_events:,
    repository_forks:,
    repository_stars:,
    repository_watchers:
  )
    # rubocop:enable Metrics/ParameterLists

    @code_of_conduct_score = is_repository_code_of_conduct_present ? 1 : 0
    @issue_participants = issue_participants
    @issue_timeline_events = issue_timeline_events
    @repository_forks = repository_forks
    @repository_stars = repository_stars
    @repository_watchers = repository_watchers
  end

  def calculate_quality
    feature_vector.inner_product(weight_vector)
  end

  def calculate_quality_progressively
    Math.log10(calculate_quality)
  end

  private

  def feature_vector
    Vector[
      @code_of_conduct_score,
      @issue_participants,
      @issue_timeline_events,
      @repository_forks,
      @repository_stars,
      @repository_watchers,
    ]
  end

  def weight_vector
    Vector[
      @feature_weights.code_of_conduct,
      @feature_weights.issue_participants,
      @feature_weights.issue_timeline_events,
      @feature_weights.repository_forks,
      @feature_weights.repository_stars,
      @feature_weights.repository_watchers,
    ]
  end
end
