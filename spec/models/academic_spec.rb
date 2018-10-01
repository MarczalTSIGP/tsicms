require 'rails_helper'

RSpec.describe Academic, type: :model do
  context 'validations' do
    let(:academic){ build(:academic) }

    it { expect(academic).to respond_to(:name) }
    it { expect(academic).to respond_to(:contact) }
    it { expect(academic).to respond_to(:graduated) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
    it { is_expected.to validate_presence_of(:contact) }
    it { is_expected.to allow_value('http://foo.com').for(:contact) }
    it { is_expected.to_not allow_value('foo.com').for(:contact) }

  end
end

