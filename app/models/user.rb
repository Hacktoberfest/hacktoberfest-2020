# frozen_string_literal: true

class User < ApplicationRecord
  with_options if: :run_registration_validations do |confirm|
    confirm.validates :terms_acceptance, acceptance: true
    confirm.validates :email, presence: true
  end

  def update_registration_validations(*args)
    @run_registration_validations = true
    updated = update(*args)
    @run_registration_validations = false
    updated
  end

  private

  attr_accessor :run_registration_validations
end
