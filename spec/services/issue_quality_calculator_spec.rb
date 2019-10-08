# frozen_string_literal: true

require 'rails_helper'

RSpec.describe IssueQualityCalculator do
  describe '#calculate_quality' do
    context 'Given a set of features' do
      it 'calculates a quality score' do
        repository = create(
          :repository,
          forks: 100,
          stars: 500,
          watchers: 10,
          code_of_conduct_url: 'https://example.com/code_of_conduct'
        )
        issue = create(
          :issue,
          timeline_events: 5,
          participants: 2,
          repository: repository
        )
        quality_calculator = IssueQualityCalculator.new
        quality_calculator.set_features(
          is_repository_code_of_conduct_present: repository
            .code_of_conduct_url.present?,
          issue_participants: issue.participants,
          issue_timeline_events: issue.timeline_events,
          repository_forks: repository.forks,
          repository_stars: repository.stars,
          repository_watchers: repository.watchers
        )

        quality = quality_calculator.calculate_quality

        issue_timeline_event_importance = 1
        issue_participant_importance = 2
        repository_star_importance = 3
        repository_fork_importance = 10
        repository_watcher_importance = 100
        repository_code_of_conduct_importance = 1000
        code_of_conduct_score = repository.code_of_conduct_url.present? ? 1 : 0
        expected_quality = (
          issue.participants * issue_participant_importance +
          issue.timeline_events * issue_timeline_event_importance +
          code_of_conduct_score * repository_code_of_conduct_importance +
          repository.forks * repository_fork_importance +
          repository.stars * repository_star_importance +
          repository.watchers * repository_watcher_importance
        )
        expect(quality).to eq expected_quality
      end
    end
  end

  describe '#calculate_quality_progressively' do
    context 'Given a wide disparity in calculated issue quality' do
      it 'reduces the disparity while preserving the rank ordering' do
        some_small_number = 1
        some_large_number = 100
        some_giant_number = 10_000
        quality_calculator = IssueQualityCalculator.new
        quality_calculator.set_features(
          is_repository_code_of_conduct_present: true,
          issue_participants: some_small_number,
          issue_timeline_events: some_small_number,
          repository_forks: some_small_number,
          repository_stars: some_small_number,
          repository_watchers: some_small_number
        )
        small_score = quality_calculator.calculate_quality
        small_progressive_score = quality_calculator
                                  .calculate_quality_progressively.to_f
        quality_calculator.set_features(
          is_repository_code_of_conduct_present: true,
          issue_participants: some_large_number,
          issue_timeline_events: some_large_number,
          repository_forks: some_large_number,
          repository_stars: some_large_number,
          repository_watchers: some_large_number
        )
        large_progressive_score = quality_calculator
                                  .calculate_quality_progressively
        quality_calculator.set_features(
          is_repository_code_of_conduct_present: true,
          issue_participants: some_giant_number,
          issue_timeline_events: some_giant_number,
          repository_forks: some_giant_number,
          repository_stars: some_giant_number,
          repository_watchers: some_giant_number
        )
        giant_score = quality_calculator.calculate_quality.to_f
        giant_progressive_score = quality_calculator
                                  .calculate_quality_progressively.to_f

        expect(giant_progressive_score).to be > large_progressive_score
        expect(large_progressive_score).to be > small_progressive_score
        min_desired_disparity_reduction = 100.0
        original_quality_disparity = giant_score / small_score
        progressive_quality_disparity = giant_progressive_score / small_progressive_score
        expect(progressive_quality_disparity)
          .to be < original_quality_disparity / min_desired_disparity_reduction
      end
    end
  end
end
