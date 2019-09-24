# frozen_string_literal: true

require 'rails_helper'

RSpec.describe IssueUpdateJob, type: :job do
  ActiveJob::Base.queue_adapter = :test

  let(:issue) { FactoryBot.create(:issue) }

  it 'calls the issue update service' do
    expect(IssueUpdateService).to receive(:call).once.with(issue)
    IssueUpdateJob.perform_now(issue.id)
  end
end
