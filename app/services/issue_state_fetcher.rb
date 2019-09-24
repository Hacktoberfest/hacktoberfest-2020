class IssueStateFetcher
  def initialize(api_client:)
    @api_client = api_client
  end

  def fetch!(issue)
    query = IssueStateQueryComposer.compose(
      issue_number: issue.number,
      owner_name: issue.repository.full_name.split("/").first,
      repo_name: issue.repository.name,
    )
    response = @api_client.request(query)

    if response_is_invalid_due_to_missing_repo? response
      raise IssueStateFetcherInvalidRepoError.new(
        response["errors"].first["message"],
        errors: response["errors"],
        query: query,
      )
    elsif response_is_invalid? response
      raise IssueStateFetcherError.new(
        response["errors"].first["message"],
        errors: response["errors"],
        query: query,
      )
    else
      response["data"]["repository"]["issue"]["state"]
    end
  end

  private

  def response_is_invalid_due_to_missing_repo?(response)
    response["errors"].present? && response["errors"].first["type"] == "NOT_FOUND"
  end

  def response_is_invalid?(response)
    response["errors"].present?
  end
end
