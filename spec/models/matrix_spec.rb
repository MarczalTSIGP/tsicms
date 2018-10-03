require 'rails_helper'

RSpec.describe Matrix, type: :model do
  describe 'validate' do
    subject {create(:matrix)}

    it { is_expected.to validate_presence_of(:name)}
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive}

    it { is_expected.to have_many(:periods) }
  end
end
