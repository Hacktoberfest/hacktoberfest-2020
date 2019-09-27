# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransitionAllUsersJob, type: :job do
  Sidekiq::Testing.inline!

  before do
    2.times { FactoryBot.create(:user) }
  end

  it 'calls the UserTransitionJob for all users' do
    expect(UserTransitionJob).to receive(:perform_async).twice
    TransitionAllUsersJob.perform_async
  end
end
