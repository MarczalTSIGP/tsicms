require 'rails_helper'

RSpec.describe ActivityProfessor, type: :model do

  describe 'validations' do
    it {is_expected.to validate_presence_of(:start_date)}
    it {is_expected.to validate_presence_of(:professor)}
    it {is_expected.to validate_presence_of(:activity)}
  end

  describe 'associations' do
    it {is_expected.to belong_to(:professor)}
    it {is_expected.to belong_to(:activity)}
  end

  describe '#methods' do
    it '#end_date_human when has a end_date' do
      ap = build(:activity_professor)
      expect(ap.end_date_human).to eql(I18n.l(ap.end_date, format: :long))
    end
    it '#end_date_human when has not end_date' do
      ap = build(:activity_professor, end_date: nil)
      expect(ap.end_date_human).to eql(I18n.t('helpers.currently'))
    end
  end

end
