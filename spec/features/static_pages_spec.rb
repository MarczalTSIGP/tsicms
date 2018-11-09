require 'rails_helper'

RSpec.feature 'StaticPages', type: :feature do
  describe '#show' do
    let(:static_page) { create(:static_page) }

    before(:each) do
      visit static_page_path(static_page.permalink)
    end

    it 'has the correct content' do
      expect(page).to have_content(static_page.title)
      expect(page).to have_content(static_page.sub_title)
      expect(page).to have_content(static_page.content)
    end
  end
end
