# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserTransitionJob, type: :job do
  ActiveJob::Base.queue_adapter = :test

  let(:user) { FactoryBot.create(:user) }

  it 'tries to transition the user' do
    expect(TryUserTransitionService).to receive(:call).once.with(user)
    UserTransitionJob.perform_now(user)
  end
end
