# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UserScoreboard' do
  #VCR mock request
  let (:user) { FactoryBot.create(:user) }
  let (:start_date) { DateTime.new(2019, 9, 25).utc }
  let (:end_date) { DateTime.new(2019, 11, 1).utc }
  let (:scoreboard) { UserScoreboard.new(user, start_date, end_date) }

  describe ".new" do
    context "valid arguments" do
      it "returns a UserScoreBoard" do
        expect(scoreboard).to_not be(nil)
      end
    end

    context "invalid arguments" do
      it "raises an error " do
        expect { UserScoreboard.new(123, 'abc') }.to raise_error(ArgumentError)
      end
    end

    context "no arguments provided" do
      it "raises an error " do
        expect{ UserScoreboard.new() }.to raise_error(NoArgumentError)
      end
    end
  end

  describe "#score" do
    context "a user with pull request outside allowed date-range" do
      subject { UserScoreboard.new(user, DateTime.new(2017, 9, 25).utc , DateTime.new(2017, 11, 1).utc ) }

      it "returns an integer" do
        expect(subject.score).to eq(0)
      end
    end

    context "a user with pull request within allowed date-range" do
      subject { UserScoreboard.new(scoreboard, start_date, end_date) }

      it "returns does not add invalid pull requests to the score" do
        expect(subject.score).to be_a(Integer)
      end

    end
   end
end
