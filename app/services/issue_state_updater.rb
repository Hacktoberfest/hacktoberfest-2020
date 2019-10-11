# frozen_string_literal: true

class IssueStateUpdater
  def self.update(issue:, state:)
    if issue.open && state == IssueStates::CLOSED
      issue.open = false
      issue.save
    elsif !issue.open && state == IssueStates::OPEN
      issue.open = true
      issue.save
    elsif !IssueStates::ALL.include? state
      raise "IssueStateUpdater.update called with unknown state #{state}"
    end
  end
end
