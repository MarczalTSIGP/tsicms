require 'rails_helper'

RSpec.describe Professor, type: :model do
  describe 'validates' do
    it {is_expected.to validate_presence_of(:name)}
    it {is_expected.to validate_presence_of(:lattes)}
    it {is_expected.to validate_presence_of(:occupation_area)}
    it {is_expected.to validate_presence_of(:email)}
    it {is_expected.to validate_presence_of(:professor_title)}
    it {is_expected.to validate_presence_of(:professor_category)}

    it { is_expected.to allow_value("email@addresse.foo").for(:email) }
    it { is_expected.to_not allow_value("foo").for(:email) }

    it { is_expected.to allow_value("https://google.com").for(:lattes) }
    it { is_expected.to_not allow_value("google.com").for(:lattes) }
  end

  describe 'associations' do
    it {is_expected.to belong_to(:professor_category)}
    it {is_expected.to belong_to(:professor_title)}
  end
end
