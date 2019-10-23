# frozen_string_literal: true

module ImportAllMetadataService
  module_function

  def call
    User.select(:id).find_in_batches do |group|
      group.each do |user|
        ImportUserMetadataJob.perform_async(user.id)
        ImportPRMetadataJob.perform_async(user.id)
        ImportRepoMetadataJob.perform_async(user.id)
      end
    end
  end
end
