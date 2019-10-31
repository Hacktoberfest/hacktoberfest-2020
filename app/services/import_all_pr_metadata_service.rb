# frozen_string_literal: true

module ImportAllPrMetadataService
  module_function

  def call
    job_counter = 0

    User.select(:id).find_in_batches do |group|
      group.each do |user|
        ImportPrMetadataJob.perform_async(user.id)

        job_counter += 1
      end
    end

    job_counter
  end
end
