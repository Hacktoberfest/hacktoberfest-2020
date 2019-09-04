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
        expect { UserEmailService.new(123, 'xy') }.to raise_error(ArgumentError)
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

    context 'a valid user UserEmailService have at least one email' do
      subject { UserEmailService.new(user) }
      it 'returns an array of emails', vcr: { record: :new_episodes } do
        expect(subject.emails.length).to_not eq(0)
      end
    end
  end
end
