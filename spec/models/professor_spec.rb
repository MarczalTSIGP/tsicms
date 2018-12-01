require 'rails_helper'

RSpec.describe Professor, type: :model do
  describe 'validates' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:lattes) }
    it { is_expected.to validate_presence_of(:occupation_area) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:professor_title) }
    it { is_expected.to validate_presence_of(:professor_category) }

    context 'with email' do
      it { is_expected.to allow_value('email@addresse.foo').for(:email) }
      it { is_expected.not_to allow_value('foo').for(:email) }

      it { is_expected.to allow_value('https://google.com').for(:lattes) }
      it { is_expected.not_to allow_value('google.com').for(:lattes) }
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:professor_category) }
    it { is_expected.to belong_to(:professor_title) }

    it { is_expected.to have_many(:activity_professors).dependent(:restrict_with_error) }
    it { is_expected.to have_many(:activities).through(:activity_professors) }
  end
end
