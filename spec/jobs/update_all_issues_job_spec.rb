# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateAllIssuesJob, type: :job do
  Sidekiq::Testing.inline!

  before do
    2.times { FactoryBot.create(:issue) }
  end

  it 'calls the IssueUpdateJob for all issues' do
    expect(IssueUpdateJob).to receive(:perform_async).twice
    UpdateAllIssuesJob.perform_async
  end
end
