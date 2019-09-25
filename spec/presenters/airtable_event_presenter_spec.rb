# frozen_string_literal=>true

require 'rails_helper'

describe AirtableEventPresenter do
  context 'Given an event with all fields' do
    it 'exposes the expected properties' do
      event = {
        "Event Name"=>"Test Event",
        "Event City"=>"Indore",
        "Event Country"=>"India",
        "Event Start Date"=>"2019-10-19",
        "Event URL"=>"https://www.meetup.com",
        "Event Organizer"=>"Facebook Developers Circle Indore",
        "Published?"=>true,
        "Contact Email"=>"test@mail.com",
        "Contact Name"=>"Mrinal Jain",
        "Agreed to CoC?"=>true,
        "Public Event?"=>true,
        "Event State"=>"Madhya Pradesh",
        "Non-Public Event Note"=>"-",
        "Event Capacity"=>200,
        "Note"=>"meetup content only visible to members",
        "Code Sent"=>"9/24",
        "Reviewed By"=>"Samantha",
        "Event Start Time"=>"10:00",
        "Event Start Date/Time"=>"2019-10-19T10:00:00.000Z",
        "Submitted Time"=>"2019-09-24T20:58:11.000Z",
        "Event Start Date/Time (Real)"=>"10/19/2019 10:00"
      }

      event_presenter = AirtableEventPresenter.new(event)

      expect(event_presenter.name).to eq event['Event Name']
      expect(event_presenter.date)
        .to eq DateTime.parse(event['Event Start Date/Time'])
      expect(event_presenter.city).to eq event['Event City']
      expect(event_presenter.state).to eq event['Event State']
      expect(event_presenter.country).to eq event['Event Country']
      expect(event_presenter.location).to include(
        event['Event City'],
        event['Event State'],
        event['Event Country'])
      expect(event_presenter.url).to eq event['Event URL']
      expect(event_presenter.published?).to eq event['Published?']
    end
  end
end
