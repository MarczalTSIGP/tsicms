require 'rails_helper'

RSpec.describe Discipline, type: :model do
  describe 'validates' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
    it { is_expected.to validate_presence_of(:code) }
    it { is_expected.to validate_presence_of(:hours) }
    it { is_expected.to validate_presence_of(:menu) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:period) }
  end
end
