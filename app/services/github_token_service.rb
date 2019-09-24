# frozen_string_literal: true

module GithubTokenService
  module_function

  def random
    User.where.not(provider_token: nil)
        .order(Arel.sql('RANDOM()'))
        .first
        .provider_token
  end
end
