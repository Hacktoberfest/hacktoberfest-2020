# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectImportJob, type: :job do
  Sidekiq::Testing.inline!

  it 'calls the issue update service' do
    query_string = 'language:Ruby'
    expect(ProjectImportService).to receive(:call).with(query_string)
    ProjectImportJob.perform_async(query_string)
  end
end
