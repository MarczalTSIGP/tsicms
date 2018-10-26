require 'rails_helper'

RSpec.describe DisciplineMonitorProfessor, type: :model do
  context 'validations' do
    let(:discipline_monitor_professor){ build(:discipline_monitor_professor) }

    it {is_expected.to validate_presence_of(:professor)}
    it {is_expected.to validate_presence_of(:discipline_monitor)}

  end
end
