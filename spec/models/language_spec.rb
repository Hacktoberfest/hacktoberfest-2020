require "rails_helper"

RSpec.describe Language, type: :model do
  describe "validations" do
    subject { build(:language) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  end
end
