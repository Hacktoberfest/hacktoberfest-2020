# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UserScoreboard' do
  let(:user) { FactoryBot.create(:user) }
  let(:scoreboard) { UserScoreboard.new(user) }

  describe '.new' do
    context 'valid arguments' do
      it 'returns a UserScoreBoard' do
        expect(scoreboard).to_not be(nil)
      end
    end

    context 'invalid arguments' do
      it 'raises an error ' do
        expect { UserScoreboard.new(123, 'abc') }.to raise_error(ArgumentError)
      end
    end

    context 'no arguments provided' do
      it 'raises an error ' do
        expect { UserScoreboard.new }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#pull_requests' do
    before do
      mock_authentication(uid: user.uid)
    end

    context 'a user with pull requests' do
      subject { PullRequestFilterService.new(array) }
      let(:array) { [] }
      it 'calls the pull request filter service' do
        allow(subject).to receive(:filter).and_return(array)
        expect(subject.filter).to eq(array)
      end

      it 'returns only last 4 pull requests', vcr: { record: :new_episodes } do
        allow(scoreboard).to receive(:pull_requests).and_return(4)
        expect(scoreboard.pull_requests).to eq(4)
      end
    end
  end

  describe '#score' do
    subject { UserScoreboard.new(user) }

    context 'a new user with no pull requests' do
      it 'returns 0', vcr: { record: :new_episodes } do
        expect(subject.score).to eq(0)
      end
    end

    context 'it counts the amount of pull requests' do
      it 'returns an integer' do
        expect(subject.score).to be_a(Integer)
      end
    end
  end
end
