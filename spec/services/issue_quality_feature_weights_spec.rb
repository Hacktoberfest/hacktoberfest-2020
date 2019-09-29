require "rails_helper"

RSpec.describe IssueQualityFeatureWeights do
  describe ".new" do
    it "returns an object with feature weights" do
      feature_weights = IssueQualityFeatureWeights.new

      expect(feature_weights).to respond_to :code_of_conduct
      expect(feature_weights).to respond_to :issue_participants
      expect(feature_weights).to respond_to :issue_timeline_events
      expect(feature_weights).to respond_to :repository_forks
      expect(feature_weights).to respond_to :repository_stars
      expect(feature_weights).to respond_to :repository_watchers
    end
  end

  describe ".default_weights" do
    it "returns an object with certain default feature weights" do
      weights = IssueQualityFeatureWeights.default_weights

      expect(weights.code_of_conduct).to eq IssueQualityFeatureWeights::CODE_OF_CONDUCT
      expect(weights.issue_participants).to eq IssueQualityFeatureWeights::ISSUE_PARTICIPANTS
      expect(weights.issue_timeline_events).to eq IssueQualityFeatureWeights::ISSUE_TIMELINE_EVENTS
      expect(weights.repository_forks).to eq IssueQualityFeatureWeights::REPOSITORY_FORKS
      expect(weights.repository_stars).to eq IssueQualityFeatureWeights::REPOSITORY_STARS
      expect(weights.repository_watchers).to eq IssueQualityFeatureWeights::REPOSITORY_WATCHERS
    end
  end
end
