class Repository < ActiveRecord::Base
  MAX_DESCRIPTION_LENGTH = 180

  before_validation :truncate_description

  belongs_to :language
  has_many :pull_requests, dependent: :destroy

  validates :full_name, presence: true
  validates :gh_database_id, presence: true, uniqueness: true
  validates :name, presence: true
  validates :url, presence: true, uniqueness: true

  def self.with_highest_prs_count(limit = 20)
    select('count(pull_requests.id) as prs_count, repositories.*').
      excluding_hacktoberfest_repos.
      joins(:pull_requests).
      where(pull_requests: { is_valid: true }).
      group(:id).
      order("prs_count DESC").
      limit(limit)
  end

  def self.excluding_hacktoberfest_repos
    where.not("lower(full_name) LIKE '%hacktoberfest%'")
  end

  def self.total_count
    joins(:pull_requests).where(pull_requests: { is_valid: true }).distinct.count
  end

  private

  def truncate_description
    if description.present?
      self.description = description.truncate(MAX_DESCRIPTION_LENGTH)
    end
  end
end
