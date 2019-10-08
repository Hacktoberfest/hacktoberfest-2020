# frozen_string_literal: true

require 'rails_helper'

describe IssueStates do
  describe '::OPEN' do
    it "returns the string 'OPEN'" do
      expect(IssueStates::OPEN).to eq 'OPEN'
    end
  end

  describe '::CLOSED' do
    it "returns the string 'CLOSED'" do
      expect(IssueStates::CLOSED).to eq 'CLOSED'
    end
  end

  describe '::ALL' do
    it 'returns an array with ::OPEN and ::CLOSED' do
      expect(IssueStates::ALL).to eq [IssueStates::CLOSED, IssueStates::OPEN]
    end
  end
end
