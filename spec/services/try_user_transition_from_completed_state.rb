# frozen_string_literal: true

module TryUserTransitionFromCompletedService
  def self.call(user)
    return unless user.state == 'won_shirt' || user.state == 'won_sticker'

    # user.wait
  end
end
