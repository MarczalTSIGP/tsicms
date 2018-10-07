require 'rails_helper'

RSpec.describe ActivityProfessor, type: :model do
  describe 'validations' do
    it {is_expected.to validate_presence_of(:start_date)}
    it {is_expected.to validate_presence_of(:professor)}
    it {is_expected.to validate_presence_of(:activity)}
  end
  describe 'associations' do
    it {should belong_to(:professor)}
    it {should belong_to(:activity)}
  end
end
