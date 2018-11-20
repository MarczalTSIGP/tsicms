require 'rails_helper'

RSpec.describe 'Galleries', type: :feature do
  describe '#index' do
    let(:admin) { create(:admin) }
    let(:gallery) { create(:gallery) }

    before(:each) do
      login_as(admin, scope: :admin)
    end

    it 'has the correct content' do
      visit admins_galleries_path(gallery.context)

      expect(page).to have_css("#gallery-#{gallery.context}")
    end
  end
end
