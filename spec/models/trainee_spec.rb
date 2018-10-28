require 'rails_helper'

RSpec.describe Trainee, type: :model do
  describe 'validation' do
    it {is_expected.to validate_presence_of(:company)}
    it {is_expected.to validate_presence_of(:treinee_status)}
    it {is_expected.to validate_presence_of(:title)}
    it {is_expected.to validate_presence_of(:description)}
  end
  describe 'association' do
    it {is_expected.to belong_to(:company)}
    it {is_expected.to belong_to(:treinee_status)}
  end
end
