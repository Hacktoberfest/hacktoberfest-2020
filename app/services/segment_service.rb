# frozen_string_literal: true

class SegmentService
  SEGMENT_API_URL = 'https://api.segment.io/v1'

  def initialize(client: nil, user: user, access_token: ENV['SEGMENT_WRITE_KEY'])
    @client = client
    @user = user
    @access_token = access_token
  end

  def identify(traits = {})
    data = {
      type: "identify",
      traits: traits,
      userId: @user.id
    }
    request('identify', data)
  end

  def track(event_name)
    json = {
      type: "track",
      event: event_name,
      userId: @user.id
    }

    request('track', json)
  end

  protected

  def request(endpoint, data)
    response = client.post(SEGMENT_API_URL + "/#{endpoint}",
                           data.to_json,
                           'Authorization': "Basic #{@access_token}",
                           'Content-Type': 'application/json')
  end

  def client
    @client ||= Hacktoberfest.client
  end
end
