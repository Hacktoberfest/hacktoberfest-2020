# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransitionAllUsersJob, type: :job do
  ActiveJob::Base.queue_adapter = :test

  before do
    2.times { FactoryBot.create(:user) }
  end

  it 'calls the UserTransitionJob for all users' do
    expect(UserTransitionJob).to receive(:perform_later).twice
    TransitionAllUsersJob.perform_now
  end
end
