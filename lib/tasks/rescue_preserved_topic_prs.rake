# frozen_string_literal: true

namespace :rescue_preserved_topic_prs do
  task update_prs: :environment do
    PreservedTopicPR.find_each do |preserved_pr|
      pr = PullRequest.find_by(gh_id: preserved_pr.gh_id)

      return unless pr.present?
      return unless pr.state == 'topic_missing'

      pr.update_attribute('state', 'waiting')
      pr.update_attribute('waiting_since', pr.waiting_since || (Hacktoberfest.end_date - 1.minute))
    end
  end

  task update_users: :environment do
    User.find_each do |user|
      # If the user was affected and it caused them to lose, reset them
      if user.incompleted? && user.any_waiting_prs?
        if user.sufficient_waiting_or_eligible_prs?
          user.update_attribute('state', 'waiting')
          user.update_attribute('waiting_since', user.pull_request_service.waiting_prs.map(&:waiting_since).sort[3 - user.eligible_pull_requests_count])
        else
          user.update_attribute('state', 'registered')
        end
        user.update_attribute('receipt', nil)
        SegmentService.new(user).identify(state: user.state)
      end

      # Touch the PRs to ensure Segment is correct
      user.pull_requests

      # Try transitioning the user
      TryUserTransitionService.call(user)
    end
  end
end
