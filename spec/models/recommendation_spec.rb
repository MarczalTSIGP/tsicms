require 'rails_helper'

RSpec.describe Recommendation, type: :model do
  describe 'validates' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { should belong_to(:category_recommendation) }
  end
end
