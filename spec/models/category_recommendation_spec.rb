require 'rails_helper'

RSpec.describe CategoryRecommendation, type: :model do
  describe 'validates' do
    subject { create(:category_recommendation) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
    it { is_expected.to have_many(:recommendations).dependent(:destroy) }
  end
end
