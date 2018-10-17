require 'rails_helper'

RSpec.describe StaticPage, type: :model do
  describe 'validates' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_uniqueness_of(:permalink).case_insensitive }
  end

  describe 'validates permalink pattern' do
    it { is_expected.to allow_value('awesome-page').for(:permalink) }
    it { is_expected.to_not allow_value('awesome@page').for(:permalink) }
    it { is_expected.to_not allow_value('awesome#page').for(:permalink) }
  end
end

