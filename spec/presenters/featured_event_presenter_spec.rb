# frozen_string_literal: true

require 'rails_helper'

describe FeaturedEventPresenter do
  describe '#initialize' do
    context 'Given an event with all fields' do
      let(:event) do
        {
          'Event Named' => 'Test Event',
          'Event City' => 'Indore',
          'Event Country' => 'India',
          'Date' => '2020-10-19',
          'Link' => 'https://www.meetup.com'
        }
      end

      it 'exposes the expected properties' do
        event_presenter = FeaturedEventPresenter.new(event)

        expect(event_presenter.name).to eq event['Event Named']
        expect(event_presenter.date)
          .to eq Date.strptime(event['Date'], '%Y-%m-%d')
        expect(event_presenter.country).to eq event['Event Country']
        expect(event_presenter.city).to eq event['Event City']
        expect(event_presenter.location).to include(
          event['Event City'],
          event['Event Country']
        )
        expect(event_presenter.url).to eq event['Link']
      end
    end

    context 'Given an invalid event object' do
      let(:event) {}

      it 'raises a parse error and does not instantiate the presenter' do
        expect { FeaturedEventPresenter.new(event) }
          .to raise_error(FeaturedEventPresenter::ParseError)
      end
    end

    context 'Given an event with missing required fields' do
      let(:event) do
        {
          'Event Named' => 'Test Event',
          'Event City' => 'Indore',
          'Event Country' => 'India',
          'Date' => '2020-10-19'
        }
      end

      it 'raises a parse error and does not instantiate the presenter' do
        expect { FeaturedEventPresenter.new(event) }
          .to raise_error(FeaturedEventPresenter::ParseError)
      end
    end
  end
  describe '#current?' do
    let(:event) do
      {
        'Event Named' => 'Test Event',
        'Event City' => 'Indore',
        'Event Country' => 'India',
        'Date' => '2020-10-19',
        'Link' => 'https://www.meetup.com'
      }
    end

    before do
      allow(Date).to receive(:yesterday).and_return(Date.parse('2020-10-14'))
    end

    context 'given an event after yesterday' do
      before do
        allow_any_instance_of(FeaturedEventPresenter)
          .to receive(:date).and_return(Date.parse('2020-10-22'))
      end

      it 'returns true' do
        event_presenter = FeaturedEventPresenter.new(event)

        expect(event_presenter.current?).to eq true
      end
    end

    context 'given an event before yesterday' do
      before do
        allow_any_instance_of(FeaturedEventPresenter)
          .to receive(:date).and_return(Date.parse('2020-10-12'))
      end

      it 'returns false' do
        event_presenter = FeaturedEventPresenter.new(event)

        expect(event_presenter.current?).to eq false
      end
    end
  end
end
