# frozen_string_literal: true

require 'rails_helper'

describe MlhEventPresenter do
  # rubocop:disable Metrics/LineLength

  describe '#initialize' do
    context 'Given an event with all fields' do
      let(:event) do
        {
          'attributes' => {
            'title' => 'Hacktoberfest in Brasilia',
            'startDate' => '2020-10-16',
            'timeZone' => 'America/Sao_Paulo',
            'location' => {
              'city' => 'Brasilia',
              'country' => 'Brazil'
            }
          },
          'links' => {
            'register' => 'http://organize.mlh.io/participants/events/3921-hacktoberfest-in-brasilia/register',
            'view' => 'http://organize.mlh.io/participants/events/3921-hacktoberfest-in-brasilia'
          }
        }
      end

      it 'exposes the expected properties' do
        event_presenter = MlhEventPresenter.new(event)

        expect(event_presenter.name).to eq event.dig('attributes', 'title')
        expect(event_presenter.date)
          .to eq Date.strptime(event.dig('attributes', 'startDate'), '%Y-%m-%d')
        expect(event_presenter.country).to eq event.dig('attributes', 'location', 'country')
        expect(event_presenter.time_zone).to eq event.dig('attributes', 'timeZone').gsub(/_/, ' ')
        expect(event_presenter.city).to eq event.dig('attributes', 'location', 'city')
        expect(event_presenter.location).to include(
          event.dig('attributes', 'location', 'city'),
          event.dig('attributes', 'location', 'country')
        )
        expect(event_presenter.url).to eq event.dig('links', 'view')
      end
    end

    context 'Given an invalid event object' do
      let(:event) {}

      it 'raises a parse error and does not instantiate the presenter' do
        expect { MlhEventPresenter.new(event) }
          .to raise_error(MlhEventPresenter::ParseError)
      end
    end

    context 'Given an event with missing required fields' do
      let(:event) do
        {
          'attributes' => {
            'title' => 'Hacktoberfest in Brasilia',
            'startDate' => '2020-10-16',
            'location' => {
              'city' => 'Brasilia',
              'country' => 'Brazil'
            }
          }
        }
      end

      it 'raises a parse error and does not instantiate the presenter' do
        expect { MlhEventPresenter.new(event) }
          .to raise_error(MlhEventPresenter::ParseError)
      end
    end
  end

  describe '#current?' do
    let(:event) do
      {
        'attributes' => {
          'title' => 'Hacktoberfest in Brasilia',
          'startDate' => '2020-10-16',
          'timeZone' => 'America/Sao_Paulo',
          'location' => {
            'city' => 'Brasilia',
            'country' => 'Brazil'
          }
        },
        'links' => {
          'register' => 'http://organize.mlh.io/participants/events/3921-hacktoberfest-in-brasilia/register',
          'view' => 'http://organize.mlh.io/participants/events/3921-hacktoberfest-in-brasilia'
        }
      }
    end

    before do
      allow(Date).to receive(:yesterday).and_return(Date.parse('2020-10-14'))
    end

    context 'given an event after yesterday' do
      before do
        allow_any_instance_of(MlhEventPresenter)
          .to receive(:date).and_return(Date.parse('2020-10-22'))
      end

      it 'returns true' do
        event_presenter = MlhEventPresenter.new(event)

        expect(event_presenter.current?).to eq true
      end
    end

    context 'given an event before yesterday' do
      before do
        allow_any_instance_of(MlhEventPresenter)
          .to receive(:date).and_return(Date.parse('2020-10-12'))
      end

      it 'returns false' do
        event_presenter = MlhEventPresenter.new(event)

        expect(event_presenter.current?).to eq false
      end
    end
  end
  # rubocop:enable Metrics/LineLength
end
