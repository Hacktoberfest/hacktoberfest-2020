# frozen_string_literal: true

class IssueQualityUpdater
  def self.update_all
    issue_quality_calculator = IssueQualityCalculator.new

    Issue.includes(:repository).find_each do |issue|
      rep = issue.repository
      issue_quality_calculator.set_features(
        is_repository_code_of_conduct_present: rep.code_of_conduct_url.present?,
        issue_participants: issue.participants,
        issue_timeline_events: issue.timeline_events,
        repository_forks: rep.forks,
        repository_stars: rep.stars,
        repository_watchers: rep.watchers
      )
      issue.quality = issue_quality_calculator.calculate_quality_progressively
      issue.save
    end
  end
end
