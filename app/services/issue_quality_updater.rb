# frozen_string_literal: true

class IssueQualityUpdater
  def self.update_all
    issue_quality_calculator = IssueQualityCalculator.new

    Issue.includes(:repository).find_each do |issue|
      repository = issue.repository
      issue_quality_calculator.set_features(
        is_repository_code_of_conduct_present: repository.code_of_conduct_url.present?,
        issue_participants: issue.participants,
        issue_timeline_events: issue.timeline_events,
        repository_forks: repository.forks,
        repository_stars: repository.stars,
        repository_watchers: repository.watchers
      )
      issue.quality = issue_quality_calculator.calculate_quality_progressively
      issue.save
    end
  end
end
