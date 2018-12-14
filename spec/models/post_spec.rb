require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validates' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:post_category) }
  end
end
