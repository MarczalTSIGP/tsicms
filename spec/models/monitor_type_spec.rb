require 'rails_helper'

RSpec.describe MonitorType, type: :model do
  context 'validations' do
    let(:monitor_type){ build(:monitor_type) }

    it { expect(monitor_type).to respond_to(:name) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to have_many(:discipline_monitors).dependent(:destroy) }
  end
end


