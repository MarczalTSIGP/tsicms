require 'rails_helper'
RSpec.describe Period, type: :model do
  describe 'validates' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive.scoped_to(:matrix_id) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:matrix) }
    it { is_expected.to have_many(:disciplines).dependent(:destroy) }
  end
end
