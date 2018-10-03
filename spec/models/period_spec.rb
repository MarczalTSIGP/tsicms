require 'rails_helper'

RSpec.describe Period, type: :model do
  describe 'validate' do
    subject {create(:period)}

    it { is_expected.to validate_presence_of(:name)}
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive}

    it { is_expected.to have_many(:disciplines) }
    it { should belong_to(:matrix) }
    
  end
  
end
