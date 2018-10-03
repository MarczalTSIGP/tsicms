require 'rails_helper'

RSpec.describe Discipline, type: :model do
  describe 'validates' do
    subject {create(:discipline)}
    
    it { is_expected.to validate_presence_of(:name)}
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }

    it { is_expected.to validate_presence_of(:code)}
    it { is_expected.to validate_presence_of(:hours)}
    

    it { should belong_to(:period) }
    
  end
end
