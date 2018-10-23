require 'rails_helper'

RSpec.describe DisciplineMonitor, type: :model do
  context 'validations' do
    let(:discipline_monitor){ build(:discipline_monitor) }

    it { is_expected.to validate_presence_of(:year) }
    it { is_expected.to validate_presence_of(:semester) }
    it { is_expected.to validate_presence_of(:description) }
    it {is_expected.to validate_presence_of(:academic)}
    it {is_expected.to validate_presence_of(:monitor_type)}
  end

  describe 'associations' do

    it { is_expected.to have_many(:discipline_monitor_professors) }
    it { is_expected.to have_many(:professors).through(:discipline_monitor_professors) }

  end
end



