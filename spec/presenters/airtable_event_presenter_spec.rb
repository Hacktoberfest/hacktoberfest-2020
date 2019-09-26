# frozen_string_literal: true

# frozen_string_literal=>true

require 'rails_helper'

describe AirtableEventPresenter do
  describe '#initialize' do
    context 'Given an event with all fields' do
      let(:event) do
        {
          'Event Name' => 'Test Event',
          'Event City' => 'Indore',
          'Event Country' => 'India',
          'Event Start Date' => '2019-10-19',
          'Event URL' => 'https://www.meetup.com',
          'Event Organizer' => 'Facebook Developers Circle Indore',
          'Published?' => true,
          'Featured?' => true,
          'Contact Email' => 'test@mail.com',
          'Contact Name' => 'Mrinal Jain',
          'Agreed to CoC?' => true,
          'Public Event?' => true,
          'Event State' => 'Madhya Pradesh',
          'Non-Public Event Note' => '-',
          'Event Capacity' => 200,
          'Note' => 'meetup content only visible to members',
          'Code Sent' => '9/24',
          'Reviewed By' => 'Samantha',
          'Event Start Time' => '10:00',
          'Event Start Date/Time' => '2019-10-19T10:00:00.000Z',
          'Submitted Time' => '2019-09-24T20:58:11.000Z',
          'Event Start Date/Time (Real)' => '10/19/2019 10:00'
        }
      end

      it 'exposes the expected properties' do
        event_presenter = AirtableEventPresenter.new(event)

        expect(event_presenter.name).to eq event['Event Name']
        expect(event_presenter.date)
          .to eq Date.strptime(
            event['Event Start Date/Time (Real)'].split(' ').first,
            '%m/%d/%Y'
          )
        expect(event_presenter.state).to eq event['Event State']
        expect(event_presenter.country).to eq event['Event Country']
        expect(event_presenter.location).to include(
          event['Event City'],
          event['Event State'],
          event['Event Country']
        )
        expect(event_presenter.url).to eq event['Event URL']
        expect(event_presenter.published?).to eq event['Published?']
        expect(event_presenter.featured?).to eq event['Featured?']
      end
    end

    context 'Given an invalid event object' do
      let(:event) { 'test' }

      it 'raises a parse error and does not instantiate the presenter' do
        expect { AirtableEventPresenter.new(event) }.to raise_error(AirtableEventPresenter::ParseError)
      end
    end

    context 'Given an event with missing required fields' do
      let(:event) do
        {
          'Event City' => 'Indore',
          'Event Country' => 'India',
          'Event Start Date' => '2019-10-19',
          'Event URL' => 'https://www.meetup.com',
          'Event Start Time' => '10:00',
          'Event Start Date/Time' => '2019-10-19T10:00:00.000Z',
          'Submitted Time' => '2019-09-24T20:58:11.000Z',
          'Event Start Date/Time (Real)' => '10/19/2019 10:00'
        }
      end

      it 'raises a parse error and does not instantiate the presenter' do
        expect { AirtableEventPresenter.new(event) }.to raise_error(AirtableEventPresenter::ParseError)
      end
    end
  end
  describe '#after_yesterday?' do
    let(:event) do
      {
        'Event Name' => 'Test',
        'Event Country' => 'India',
        'Event URL' => 'https://www.meetup.com',
        'Event Start Date/Time (Real)' => '10/19/2019 10:00'
      }
    end

    before do
      allow(Date).to receive(:yesterday).and_return(Date.parse('2019-10-19'))
    end

    context 'given an event after yesterday' do
      before do
        allow_any_instance_of(AirtableEventPresenter)
          .to receive(:date).and_return(Date.parse('2019-10-22'))
      end

      it 'returns true' do
        event_presenter = AirtableEventPresenter.new(event)

        expect(event_presenter.after_yesterday?).to eq true
      end
    end

    context 'given an event before yesterday' do
      before do
        allow_any_instance_of(AirtableEventPresenter)
          .to receive(:date).and_return(Date.parse('2019-10-16'))
      end

      it 'returns false' do
        event_presenter = AirtableEventPresenter.new(event)

        expect(event_presenter.after_yesterday?).to eq false
      end
    end
  end
end
