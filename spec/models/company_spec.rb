require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'validates' do
    it {is_expected.to validate_presence_of(:name)}
    it {is_expected.to validate_presence_of(:operation)}

    context 'email' do
      it {is_expected.to allow_value('http://google.com').for(:site)}
      it {is_expected.to_not allow_value('foo').for(:site)}
    end
  end
end
