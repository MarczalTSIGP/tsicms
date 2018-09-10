require 'rails_helper'

RSpec.describe ProfessorTitle, type: :model do
  describe 'validates' do
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:abbrev) }
  end
end
