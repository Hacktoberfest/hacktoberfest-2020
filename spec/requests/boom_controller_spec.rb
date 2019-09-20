# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BoomController, type: :request do
  describe '#show' do
    it "raises the Boom error" do
      expect { get '/boom' }.to raise_error(BoomError)
    end
  end
end
