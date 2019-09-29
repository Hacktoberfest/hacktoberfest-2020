# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateAllIssuesQualityJob, type: :job do
  Sidekiq::Testing.inline!

  before do
    2.times { FactoryBot.create(:issue) }
  end

  it 'calls the IssueUpdateJob for all issues' do
    expect(IssueQualityUpdater).to receive(:update_all)
    UpdateAllIssuesQualityJob.perform_async
  end
end
