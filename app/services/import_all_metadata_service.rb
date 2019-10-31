# frozen_string_literal: true

module ImportAllMetadataService
  module_function

  def call
    job_counter = 0

    User.select(:id).find_in_batches do |group|
      group.each do |user|
        ImportUserMetadataJob.perform_async(user.id)
        ImportPrMetadataJob.perform_async(user.id)
        ImportReposMetadataJob.perform_async(user.id)

        job_counter += 3
      end
    end

    job_counter
  end
end
