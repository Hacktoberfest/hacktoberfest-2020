# frozen_string_literal: true

class User < ApplicationRecord

  with_options if: :run_registration_validations do |confirm|
    confirm.validates :terms_acceptance, acceptance: true
    confirm.validates :email, presence: true
  end

  def set_registration_validations(*args)
    run_registration_validations = true
    update(*args)
    return false unless args.first[ "terms_acceptance"] == "1"

    run_registration_validations
  end

  def finish_registration_validations(arg=false)
    validation_done = arg
  end

  private

  attr_accessor :run_registration_validations, :validation_done
end
