# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserTransitionJob, type: :job do
  Sidekiq::Testing.inline!

  let(:user) { FactoryBot.create(:user) }

  context 'user token is valid' do
    before do
      allow_any_instance_of(TokenValidatorService)
        .to receive(:valid?).and_return(true)
    end

    it 'tries to transition the user' do
      expect(TryUserTransitionService).to receive(:call).once.with(user)
      UserTransitionJob.perform_async(user.id)
    end
  end

  context 'user token  is invalid' do
    before do
      allow_any_instance_of(TokenValidatorService)
        .to receive(:valid?).and_return(false)
    end

    it 'tries does not try to transition the user' do
      expect(TryUserTransitionService).to_not receive(:call)
      UserTransitionJob.perform_async(user.id)
    end
  end
end
