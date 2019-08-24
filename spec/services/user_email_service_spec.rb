# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UserEmailService' do
  let(:user) { FactoryBot.create(:user) }

  let(:email_service) { UserEmailService.new(user) }

  describe '.new' do
    context 'valid arguments' do
      it 'returns a UserEmailService' do
        expect(email_service).to_not be(nil)
      end
    end

    context 'invalid arguments' do
      it 'raises an error ' do
        expect { UserEmailService.new(123, 'abc') }.to raise_error(ArgumentError)
      end
    end

    context 'no arguments provided' do
      it 'raises an error ' do
        expect { UserEmailService.new }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#emails' do
    before do
      mock_authentication(uid: user.uid)
    end

    context 'a valid user should have at least one email' do

    end

    context 'emails returns all of a users emails' do
      
    end
end
