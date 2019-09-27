# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserTransitionJob, type: :job do
  Sidekiq::Testing.inline!

  let(:user) { FactoryBot.create(:user) }

  it 'tries to transition the user' do
    expect(TryUserTransitionService).to receive(:call).once.with(user)
    UserTransitionJob.perform_async(user.id)
  end
end
