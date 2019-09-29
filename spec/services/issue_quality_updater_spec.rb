require "rails_helper"

RSpec.describe IssueQualityUpdater do
  describe "#update_all" do
    context "Given an array of issues" do
      it "calculates and saves the quality score for each issue" do
        repository = create(
          :repository,
          code_of_conduct_url: nil,
          forks: 20,
          stars: 40,
          watchers: 10,
        )
        issue_1 = create(
          :issue,
          repository: repository,
          quality: nil,
          participants: 1,
          timeline_events: 2,
        )
        issue_2 = create(
          :issue,
          repository: repository,
          quality: nil,
          participants: 3,
          timeline_events: 4,
        )
        issue_1_quality = 1
        issue_2_quality = 9000
        issue_quality_calculator = instance_double(IssueQualityCalculator.to_s)
        allow(issue_quality_calculator).to receive(:set_features)
        allow(issue_quality_calculator).to receive(:calculate_quality_progressively)
          .and_return(issue_1_quality, issue_2_quality)
        allow(IssueQualityCalculator).to receive(:new)
          .and_return(issue_quality_calculator)

        IssueQualityUpdater.update_all

        expect(issue_quality_calculator).to have_received(:set_features)
          .with(
            is_repository_code_of_conduct_present: repository.code_of_conduct_url.present?,
            issue_participants: issue_1.participants,
            issue_timeline_events: issue_1.timeline_events,
            repository_forks: repository.forks,
            repository_stars: repository.stars,
            repository_watchers: repository.watchers,
          ).ordered
        expect(issue_quality_calculator).to have_received(:set_features)
          .with(
            is_repository_code_of_conduct_present: repository.code_of_conduct_url.present?,
            issue_participants: issue_2.participants,
            issue_timeline_events: issue_2.timeline_events,
            repository_forks: repository.forks,
            repository_stars: repository.stars,
            repository_watchers: repository.watchers,
          ).ordered
        expect(issue_1.reload.quality).to eq issue_1_quality
        expect(issue_2.reload.quality).to eq issue_2_quality
      end
    end
  end
end
