# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateAllIssuesJob, type: :job do
  ActiveJob::Base.queue_adapter = :test

  before do
    2.times { FactoryBot.create(:issue) }
  end

  it 'calls the IssueUpdateJob for all issues' do
    expect(IssueUpdateJob).to receive(:perform_later).twice
    UpdateAllIssuesJob.perform_now
  end
end
