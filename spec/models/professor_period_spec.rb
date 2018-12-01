require 'rails_helper'

RSpec.describe ProfessorPeriod, type: :model do
  context 'validations' do
    describe 'validates' do
      it { is_expected.to validate_presence_of(:date_entry) }

    end

    describe 'associations' do
      it { is_expected.to belong_to(:professor) }

    end
  end
end
