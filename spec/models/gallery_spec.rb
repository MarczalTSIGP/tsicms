require 'rails_helper'

RSpec.describe Gallery, type: :model do
  describe 'validates' do
    subject { create(:gallery) }

    it { is_expected.to validate_presence_of(:context) }
    it { is_expected.to validate_uniqueness_of(:context).ignoring_case_sensitivity }

    # https://github.com/thoughtbot/shoulda-matchers/issues/912#issue-139584658
    # it { is_expected.to define_enum_for(:context).with(course: 'course', static_page: 'static_page') }
  end

  describe 'associations' do
    it { is_expected.to have_many(:pictures).dependent(:destroy) }
  end
end
