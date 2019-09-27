# frozen_string_literal: true

require 'rails_helper'

RSpec.describe IssueUpdateJob, type: :job do
  Sidekiq::Testing.inline!

  let(:issue) { FactoryBot.create(:issue) }

  it 'calls the issue update service' do
    expect(IssueUpdateService).to receive(:call).once.with(issue)
    IssueUpdateJob.perform_async(issue.id)
  end
end
