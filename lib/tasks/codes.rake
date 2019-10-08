# frozen_string_literal: true

require 'csv'

namespace :import do
  desc 'import Hacktoberfest t-shirt codes'
  task shirt_codes: :environment do
    location = Rails.root.join('tmp','shirt.csv')
    
    CouponsFromCSVService.call(location, ShirtCoupon)
  end

  desc 'import Hacktoberfest sticker codes'
  task sticker_codes: :environment do
    location = Rails.root.join('tmp','sticker.csv')
    
    CouponsFromCSVService.call(location, StickerCoupon)
  end
end
