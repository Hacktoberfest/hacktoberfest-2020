# frozen_string_literal: true

require 'rails_helper'

RSpec.describe IssueStateUpdater do
  describe '.update' do
    context "When the given state string is 'OPEN' and the issue is closed" do
      it 'opens the issue' do
        originally_closed_issue = create(:issue, open: false)

        IssueStateUpdater.update(
          issue: originally_closed_issue,
          state: IssueStates::OPEN
        )

        originally_closed_issue.reload
        expect(originally_closed_issue).to be_open
      end
    end

    context "When the given state string is 'CLOSED' and the issue is open" do
      it 'closes the issue' do
        originally_open_issue = create(:issue, open: true)

        IssueStateUpdater.update(
          issue: originally_open_issue,
          state: IssueStates::CLOSED
        )

        originally_open_issue.reload
        expect(originally_open_issue).not_to be_open
      end
    end

    context "When the given state string is 'OPEN' and the issue is open" do
      it 'does nothing' do
        open_issue = create(:issue, open: true)

        IssueStateUpdater.update(
          issue: open_issue,
          state: IssueStates::OPEN
        )

        open_issue.reload
        expect(open_issue).to be_open
      end
    end

    context "When the given state string is 'CLOSED' and the issue is closed" do
      it 'does nothing' do
        closed_issue = create(:issue, open: false)

        IssueStateUpdater.update(
          issue: closed_issue,
          state: IssueStates::CLOSED
        )

        closed_issue.reload
        expect(closed_issue).not_to be_open
      end
    end

    context "When the given state is string is neither 'OPEN' nor 'CLOSED'" do
      it 'raises an error' do
        issue = create(:issue)
        invalid_state = "Schrodinger's Cat"

        expect do
          IssueStateUpdater.update(issue: issue, state: invalid_state)
        end.to raise_error(
          "IssueStateUpdater.update called with unknown state #{invalid_state}"
        )
      end
    end
  end
end
