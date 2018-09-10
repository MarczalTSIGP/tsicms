require 'rails_helper'

RSpec.describe Professor, type: :model do
  describe 'validates' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:lattes) }
    it { is_expected.to validate_presence_of(:occupation_area) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:professor_title) }
    it { is_expected.to validate_presence_of(:professor_category) }
  end
end