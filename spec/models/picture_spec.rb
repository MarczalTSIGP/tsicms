require 'rails_helper'

RSpec.describe Picture, type: :model do
  describe 'validates' do
    it { is_expected.to validate_presence_of(:image) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:gallery) }
  end
end
