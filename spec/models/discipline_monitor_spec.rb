require 'rails_helper'

RSpec.describe DisciplineMonitor, type: :model do
  describe 'validations' do
    let(:discipline_monitor) { build(:discipline_monitor) }

    it { is_expected.to validate_presence_of(:year) }
    it { is_expected.to validate_presence_of(:semester) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:academic) }
    it { is_expected.to validate_presence_of(:monitor_type) }
    it { is_expected.to validate_presence_of(:professor_ids) }
    it { is_expected.to validate_presence_of(:discipline_ids) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:discipline_monitor_professors) }
    it { is_expected.to have_many(:professors).through(:discipline_monitor_professors) }

    it { is_expected.to have_many(:discipline_monitor_disciplines) }
    it { is_expected.to have_many(:disciplines).through(:discipline_monitor_disciplines) }
  end
end
