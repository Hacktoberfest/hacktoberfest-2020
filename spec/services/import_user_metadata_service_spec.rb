# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImportUserMetadataService do
  describe '.call' do
    context 'Octokit returns user data' do
      let(:user) { FactoryBot.create(:user) }

      before do
        allow_any_instance_of(Octokit::Client)
          .to receive(:user).and_return("test": 1)
      end

      context 'the user is absent in the user stats table' do
        it 'creates a UserStat' do
          ImportUserMetadataService.call(user)

          expect(UserStat.count).to eq(1)
        end
      end

      context 'the user is present in the user stats table' do
        let!(:existing_stat) do
          UserStat.create(user_id: user.id, data: { "test": 0 })
        end

        it 'does not create another UserStat' do
          ImportUserMetadataService.call(user)

          expect(UserStat.count).to eq(1)
        end

        it 'updates the UserStat' do
          ImportUserMetadataService.call(user)

          expect(UserStat.last.data).to eq('test' => 1)
        end
      end
    end
  end
end
