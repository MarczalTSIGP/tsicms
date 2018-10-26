require 'rails_helper'

RSpec.describe Activity, type: :model do
  describe 'validates' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:activity_professors).dependent(:restrict_with_error) }
    it { is_expected.to have_many(:professors).through(:activity_professors) }
  end
end
