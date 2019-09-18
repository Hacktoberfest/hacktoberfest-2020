# frozen_string_literal: true

class SegmentService
  SEGMENT_API_URL = 'https://api.segment.io/v1'
  SEGMENT_KEY = ENV['SEGMENT_WRITE_KEY']

  def initialize(user, client: nil, access_token: SEGMENT_KEY)
    @client = client
    @user = user
    @access_token = access_token
  end

  def identify(traits = {})
    data = {
      type: 'identify',
      traits: traits,
      userId: @user.id
    }
    request('identify', data)
  end

  def track(event_name)
    data = {
      type: 'track',
      event: event_name,
      userId: @user.id
    }

    request('track', data)
  end

  protected

  def transform_token(string)
    string += ':'
    Base64.encode64(string)
  end

  def request(endpoint, data)
    client.post(SEGMENT_API_URL + "/#{endpoint}",
                data.to_json,
                'Authorization': "Basic #{transform_token(@access_token)}",
                'Content-Type': 'application/json')
  end

  def client
    @client ||= Hacktoberfest.client
  end
end
