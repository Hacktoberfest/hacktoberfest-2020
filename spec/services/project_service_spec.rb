require "rails_helper"

RSpec.describe ProjectService do
  describe "#sample" do
    context "Given a sample size of zero" do
      it "returns an empty array" do
        projects = ProjectService.sample(0)

        expect(projects).to eq []
      end
    end

    context "Given a sample size greater than zero" do
      it "returns that many projects" do
        sample_size = 3
        total_issues = 4
        create_list(:issue, total_issues)

        projects = ProjectService.sample(sample_size)

        expect(projects.count).to eq(sample_size)
      end

      it "defaults to a sample size of 1" do
        total_issues = 2
        create_list(:issue, total_issues)

        projects = ProjectService.sample

        expected_default_sample_size = 1
        expect(projects.count).to eq expected_default_sample_size
      end

      it "returns only open projects belonging to permitted repositories" do
        allow(Issue).to receive(:open_issues_with_unique_permitted_repositories)
          .and_call_original

        ProjectService.sample

        expect(Issue).to have_received(:open_issues_with_unique_permitted_repositories)
      end
    end
  end
end
