# frozen_string_literal: true

require 'csv'

module CouponsFromCSVService
  class InvalidPath < StandardError; end
  module_function

  def call(path, klass)
    CSV.foreach(path, headers: true) do |row|
      code = row[0]
      coupon_scope = klass.send(:where, code: code)

      # First or create will create only if the code does not already exist
      coupon_scope.first_or_create(code: code)
    end
  rescue Errno::ENOENT
    raise InvalidPath, 'CSV file does not exist'
  end
end
