require 'rails_helper'

RSpec.describe PostCategory, type: :model do
  describe 'validates' do
    subject { create(:post_category) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
    it { is_expected.to have_many(:posts).dependent(:destroy) }
  end
end
