require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'validates' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:operation) }
    it { is_expected.to validate_presence_of(:site) }
    it { is_expected.to validate_presence_of(:image) }
  end
end
